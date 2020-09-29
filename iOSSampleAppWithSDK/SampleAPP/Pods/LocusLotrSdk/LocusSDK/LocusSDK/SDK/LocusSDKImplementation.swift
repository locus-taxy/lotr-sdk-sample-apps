import Foundation
import RxRealm
import RxSwift

class LocusSDKImplementation: LocusSDKProtocol {

    static let shared = LocusSDKImplementation()

    private weak var delegate: LocusSDKDelegate?

    private var disposeBag = DisposeBag()
    private var disposeBagInitialize: CompositeDisposable?
    private var disposeBagTracking: CompositeDisposable?

    private let status = BehaviorSubject<LocusSDKStatus>(value: .notInitialized)
    private let isOffline = BehaviorSubject<Bool>(value: true)
    private var hasStoppedTracking: Bool = false

    func initialize(params: AuthParams?, delegate: LocusSDKDelegate, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {

        if try! self.status.value() != .notInitialized {
            return
        }
        clearDisposables()
        guard let authParams = params else {
            if Provider.getDataManager().authParams != nil {
                self.delegate = delegate
                self.status.onNext(LocusSDKStatus.authenticated)
                createInitializeObservers()
                successBlock()
                return
            }
            failureBlock(LocusSDKError.reInitializeError)
            return
        }
        self.delegate = delegate
        Provider.getLocusSDKClient().login(authParams: authParams).subscribe(onNext: { response in
            let dataManager = Provider.getDataManager()
            dataManager.authParams = params
            dataManager.clientAppConfig = response?.config
            dataManager.user = response?.user
            self.status.onNext(.authenticated)
            successBlock()
        }, onError: { error in
            failureBlock(LocusSDKError.error(error))
        }).disposed(by: disposeBag)
        createInitializeObservers()
    }

    func updateAuthParams(params: AuthParams, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        do {
            try checkInit()
            Provider.getDataManager().authParams = params
            successBlock()
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    func updateAppConfig(successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        do {
            try checkInit()
            guard let authParams = Provider.getDataManager().authParams else {
                failureBlock(LocusSDKError.illegalState(message: "SDK is not initialized"))
                return
            }
            Provider.getLocusSDKClient().login(authParams: authParams).subscribe(onNext: { response in
                let dataManager = Provider.getDataManager()
                dataManager.clientAppConfig = response?.config
                successBlock()
            }, onError: { error in
                failureBlock(LocusSDKError.error(error))
            }).disposed(by: disposeBag)
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    private func createInitializeObservers() {

        let statusDisposable = self.status.subscribe(onNext: { status in
            self.delegate?.locusSDKStatusChanged(status: status)
        })

        let permissionDisposable = LocationManager.shared.permission.asObserver().subscribe(onNext: { permission in
            do {
                if try self.status.value() == .tracking && permission != .authorizedAlways {
                    self.status.onNext(.trackingWithoutPermission)
                }
                if try self.status.value() == .trackingWithoutPermission && self.hasStoppedTracking == false {
                    try self.startTracking()
                }
            } catch {}
        })
        disposeBagInitialize = CompositeDisposable(disposables: [statusDisposable, permissionDisposable])
    }

    func logout(forceLogout: Bool, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) throws {

        if try self.status.value() == .notInitialized {
            return
        }

        try stopTracking()
        OutService.shared.trigger(forceTransmit: true, {
            self.status.onNext(.notInitialized)
            Provider.getDataManager().clearStoredData()
            successBlock()
        }) { error in
            if forceLogout {
                self.status.onNext(.notInitialized)
                Provider.getDataManager().clearStoredData()
                // If forced logout clearing all the data in the OutStore DB as well
                Provider.getOutStoreDataManager().deleteAll()
                successBlock()
                return
            }
            failureBlock(LocusSDKError.error(error))
        }
    }

    func isTracking() -> Bool {
        do {
            try checkInit()
            if try status.value() == .tracking {
                return true
            }
        } catch {
            return false
        }
        return false
    }

    func startTracking() throws {

        try checkInit()
        if !AppUtil.checkPlistStringForLocationServices() {
            self.delegate?.onLocationError(error: LocusSDKError.locationPlistInfoMissing)
            throw LocusSDKError.locationPlistInfoMissing
        }
        if try LocationManager.shared.permission.value() != .authorizedAlways {
            self.status.onNext(.trackingWithoutPermission)
            LocationManager.shared.requestAuthorization()
            LocationManager.shared.stopLocationServices()
            self.delegate?.onLocationError(error: LocusSDKError.invalidLocationPermission)
            throw LocusSDKError.invalidLocationPermission
        }
        hasStoppedTracking = false
        if try status.value() == .tracking {
            return
        }

        LocationManager.shared.startLocationServices()
        self.status.onNext(LocusSDKStatus.tracking)
        let locationDisposable = LocationManager.shared.getLocationUpdates().subscribe(onNext: { location in
            let user = Provider.getDataManager().user!
            Provider.getAsyncStore().updateLocation(clientId: user.clientId!, userId: user.userId!, location: location).subscribe(onNext: { _ in
                self.delegate?.onLocationUpdated(location: location)
            }).disposed(by: self.disposeBag)
            self.checkIfOffline(location)
        })

        let lastSentDisposable = Provider.getDataManager().lastSentLocationObservable()?.subscribe(onNext: { location in
            self.delegate?.onLocationUploaded(location: location)
        })

        let offlineDisposable = isOffline.asObserver().subscribe(onNext: { value in
            self.delegate?.isOfflineStatusChanged(isOffline: value)
        })

        disposeBagTracking = CompositeDisposable(disposables: [locationDisposable, lastSentDisposable!, offlineDisposable])
    }

    func requestAuthorization() {
        LocationManager.shared.requestAuthorization()
    }

    private func checkIfOffline(_: Location) {

        var offline: Bool = true
        if let lastSentLocation = Provider.getDataManager().lastSentLocation {
            offline = AppUtil.isOlderThanSecs(time: lastSentLocation.timestamp!, seconds: Provider.getDataManager().clientAppConfig?.locationStaleTime ?? 600)
        }
        if try! self.isOffline.value() != offline {
            self.isOffline.onNext(offline)
        }
    }

    func stopTracking() throws {

        try checkInit()
        OutService.shared.trigger(forceTransmit: false)
        hasStoppedTracking = true
        LocationManager.shared.stopLocationServices()
        self.status.onNext(LocusSDKStatus.authenticated)
        disposeBagTracking?.dispose()
    }

    func sync(forceTransmit: Bool, successBlock: @escaping successBlock, failureBlock: @escaping failureBlock) throws {
        try checkInit()
        OutService.shared.trigger(forceTransmit: forceTransmit, successBlock, failureBlock)
    }

    func updateTaskStatus(taskStatusUpdateParams: TaskStatusUpdateParams) throws {

        try checkInit()
        let user = Provider.getDataManager().user!
        Provider.getAsyncStore().updateTaskStatus(clientId: user.clientId!, taskId: taskStatusUpdateParams.taskId, taskStatus: taskStatusUpdateParams.taskStatus, checklist: taskStatusUpdateParams.checklist).subscribe(onNext: { _ in
        }).disposed(by: self.disposeBag)
    }

    func updateVisitStatus(visitStatusUpdateParams: VisitStatusUpdateParams) throws {

        try checkInit()
        let user = Provider.getDataManager().user!
        Provider.getAsyncStore().updateVisitStatus(clientId: user.clientId!, taskId: visitStatusUpdateParams.taskId, visitId: visitStatusUpdateParams.visitId, visitStatus: visitStatusUpdateParams.visitStatus, checklist: visitStatusUpdateParams.checklist).subscribe(onNext: { _ in
        }).disposed(by: self.disposeBag)
    }

    func updateTourStatus(tourStatusUpdateParams: TourStatusUpdateParams) throws {

        try checkInit()
        let user = Provider.getDataManager().user!
        Provider.getAsyncStore().updateTourStatus(clientId: user.clientId!, tourId: tourStatusUpdateParams.tourId, visitId: tourStatusUpdateParams.visitId, visitStatus: VisitStatus.Status(rawValue: tourStatusUpdateParams.status.rawValue)!, checklist: tourStatusUpdateParams.checklistValues).subscribe(onNext: { _ in
        }).disposed(by: self.disposeBag)
    }

    func updateLineItemTransaction(lineItemTransactionUpdateParams: LineItemTransactionUpdateParams) throws {

        try checkInit()
        let user = Provider.getDataManager().user!
        Provider.getAsyncStore().updateLineItemTransaction(clientId: user.clientId!, taskId: lineItemTransactionUpdateParams.taskId, visitId: lineItemTransactionUpdateParams.visitId, lineItems: lineItemTransactionUpdateParams.lineItems).subscribe(onNext: { _ in
        }).disposed(by: self.disposeBag)
    }

    func uploadFile(task: Task, fileName: String, data: Data) throws {

        try checkInit()
        let user = Provider.getDataManager().user!
        guard let retrivedImage = UIImage(data: data) else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a zzz, dd-MMM-yyyy"
        let idString = task.sourceOrderId != nil ? "\(task.taskId!) - \(task.sourceOrderId!)" : "\(task.taskId!)"
        let widthId = idString.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 9.0)) + 40
        let watermarkWidth = widthId > 200 ? widthId + 20 : 220
        let size = CGSize(width: watermarkWidth, height: 40)
        let waterMarkedImage = ImageUtils.textToImage(drawText: "ID: \(idString)\nTimestamp: \(formatter.string(from: Date()))", inImage: retrivedImage, atPoint: CGPoint(x: 0, y: retrivedImage.size.height - 40), size: size)
        if let watermarkedImageData = waterMarkedImage.jpegData(compressionQuality: 1.0) {
            let success = FileUtil.saveData(data: watermarkedImageData, to: fileName)
            if success {
                Provider.getAsyncStore().uploadFile(clientId: user.clientId!, taskId: task.taskId!, filename: fileName, data: watermarkedImageData).subscribe(onNext: { _ in
                }).disposed(by: self.disposeBag)
            }
        }
    }

    func displayChecklistView(checklist: Checklist, displayConfig: LocusSDKChecklistDisplayConfig, initialValues: [String: String]?, successBlock: @escaping (ChecklistResult) -> Void) throws {

        try checkInit()
        if UIApplication.topViewController() as? ChecklistViewController != nil {
            return
        }
        let storyBoardId = "ChecklistViewController\(displayConfig.type.value)"
        let checklistView = AppStoryboard.checklist.instance.instantiateViewController(withIdentifier: storyBoardId) as! ChecklistViewController
        checklistView.checklist = checklist
        checklistView.modalPresentationStyle = .overCurrentContext
        checklistView.initialValues = initialValues
        checklistView.completionHandler = successBlock
        checklistView.displayConfig = displayConfig
        if let nav = UIApplication.topViewController()?.navigationController {
            nav.present(checklistView, animated: true) {}
            return
        }
        UIApplication.topViewController()?.present(checklistView, animated: true, completion: {})
    }

    func logEvent(tag: String, message: String, logLevel: LocusSDKLogLevel) {
        self.delegate?.logEvent(tag: tag, message: message, logLevel: logLevel)
    }

    func getLocusSDKStatus() -> LocusSDKStatus {
        return try! self.status.value()
    }

    func getLastKnownLocation() -> Location? {
        return LocationManager.shared.getLastKnownLocation()
    }

    func getLastSyncedLocation() -> Location? {
        return Provider.getDataManager().lastSentLocation
    }

    func clearDisposables() {
        disposeBagInitialize?.dispose()
        disposeBagTracking?.dispose()
        disposeBag = DisposeBag()
    }

    func checkInit() throws {
        if try self.status.value() == .notInitialized || (Provider.getDataManager().user == nil) {
            throw LocusSDKError.illegalState(message: "SDK is not initialized")
        }
    }
}
