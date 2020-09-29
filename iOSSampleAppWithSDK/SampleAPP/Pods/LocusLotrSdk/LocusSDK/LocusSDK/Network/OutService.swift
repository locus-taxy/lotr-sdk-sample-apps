import Foundation
import Moya
import RealmSwift
import RxSwift

class OutService {

    static let shared = OutService()

    fileprivate let asyncQueue = ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "OutServiceQueue"))

    private let taxyClient = Provider.getLocusSDKClient()

    let disposeBag = DisposeBag()

    func triggerBackgroundFetch(_ successBlock: @escaping successBlock, _ failureBlock: @escaping failureBlock) {

        return self.trigger(forceTransmit: false, successBlock, failureBlock)
    }

    func trigger(forceTransmit: Bool, _ successBlock: @escaping successBlock = {}, _ failureBlock: @escaping failureBlock = { _ in }) {

        self.sendUpdatesToServer(forceTransmit: forceTransmit)
            .subscribeOn(self.asyncQueue)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                successBlock()
            }, onError: { error in
                failureBlock(LocusSDKError.error(error))
            })
            .disposed(by: disposeBag)
    }

    func sendUpdatesToServer(forceTransmit: Bool) -> Observable<Bool> {

        let blukUpdateObserver = self.bulkProcessQueue(forceTransmit: forceTransmit).subscribeOn(self.asyncQueue)
        let processFilesObserver = self.processFiles().subscribeOn(self.asyncQueue)
        return Observable.zip(blukUpdateObserver, processFilesObserver)
            .subscribeOn(self.asyncQueue)
            .map { responses -> Bool in
                (responses.0.value ?? false) && responses.1
            }.do(onNext: { result in
                if result {
                    self.doPostProcessing()
                }
            })
    }

    private func doPostProcessing() {}

    private func processFiles() -> Observable<Bool> {

        return Observable.deferred { Observable.just(Provider.getOutStoreDataManager().getUnsentFiles()) }
            .flatMap { daosResult -> Observable<LocusSDKOutStoreDao> in
                Observable.from(daosResult)
            }
            .flatMap { (dao) -> Observable<Bool> in
                let url = dao.url!
                let clientId = PathDataExtractor.getClientId(in: url)
                let taskId = PathDataExtractor.getTaskId(in: url)
                let filename = PathDataExtractor.getFilename(in: url)!

                guard let data = FileUtil.getData(from: filename) else {
                    return Observable.just(false)
                }

                let threadSafeDaoRef = ThreadSafeReference(to: dao)

                return self.taxyClient.uploadFile(clientId: clientId!, taskId: taskId!, filename: filename, data: data)
                    .observeOn(self.asyncQueue)
                    .map { _ in

                        guard let resolvedDao = Provider.getOutStoreDataManager().resolve(threadSafeDaoRef) else {
                            return true
                        }

                        self.logProcessedFileDaos(processedFileDaos: [resolvedDao])

                        if !resolvedDao.isInvalidated {
                            FileUtil.deleteFile(named: filename)
                            Provider.getOutStoreDataManager().sent(dao: resolvedDao)
                        }

                        return true
                    }
            }
            .toArray()
            .map {
                !$0.contains(false)
            }.asObservable()
    }

    private func bulkProcessQueue(forceTransmit: Bool) -> Observable<ServerResponse<Bool>> {

        guard let user = Provider.getDataManager().user else {
            return Observable.just(ServerResponse.generalError("Unexpected Error - user nil"))
        }

        return Observable.deferred { Observable.just(Provider.getOutStoreDataManager().getAllDaos()) }
            .flatMap { daosResult -> Observable<ServerResponse<Bool>> in

                if daosResult.count == 0 {
                    return Observable.just(ServerResponse.success(true))
                }

                let setting = Provider.getDataManager().clientAppConfig?.asyncCommunicationSetting ?? AsyncCommunicationSetting(batchMinCount: 100, batchUpdatesTimeout: 60)
                if self.insufficientTimeElapsed(setting: setting), self.insufficientMessagesInQueue(daos: daosResult, setting: setting), !forceTransmit {
                    return Observable.just(ServerResponse.success(true))
                }

                let daosArray = daosResult.toArray()
                let splitList = try! ListUtils.split(list: daosArray, by: Provider.getDataManager().clientAppConfig?.bulkUpdateLimit ?? 100)
                return self.sendBulkUpdatesSerially(user: user, listOfDaoLists: splitList)
            }
    }

    private func sendBulkUpdatesSerially(user: User, listOfDaoLists: [[LocusSDKOutStoreDao]]) -> Observable<ServerResponse<Bool>> {

        return Observable.from(listOfDaoLists)
            .flatMap {
                dao -> Observable<ServerResponse<Bool>> in
                self.sendBulkUpdate(user: user, daos: dao)
            }
            .toArray()
            .map {
                arrayOfResponses -> ServerResponse<Bool> in
                self.allResponsesAreSuccessful(arrayOfResponses: arrayOfResponses)
            }.asObservable()
    }

    private func allResponsesAreSuccessful(arrayOfResponses: [ServerResponse<Bool>]) -> ServerResponse<Bool> {
        if let failure = arrayOfResponses.filter({ response -> Bool in
            !response.isSuccess
        }).first {
            return ServerResponse.generalError(failure.errorMessage)
        }
        return ServerResponse.success(true)
    }

    private func sendBulkUpdate(user: User, daos: [LocusSDKOutStoreDao]) -> Observable<ServerResponse<Bool>> {

        let (processedDaos, bulkUpdates) = self.processNonFileDaos(daos: daos)

        let threadSafeProcessedDaos = processedDaos.map { ThreadSafeReference(to: $0) }

        if bulkUpdates.updates!.isEmpty {
            return Observable.just(ServerResponse.success(true))
        }

        return self.taxyClient.bulk(clientId: user.clientId!, userId: user.userId!, bulkUpdates: bulkUpdates)
            .observeOn(self.asyncQueue)
            .map { _ in

                NetworkStateManager.recordNetworkSuccess()

                let outStoreDataManager = Provider.getOutStoreDataManager()
                let resolvedProcessedDaos = threadSafeProcessedDaos.map { outStoreDataManager.resolve($0) }.compactMap { $0 }

                resolvedProcessedDaos.filter { !$0.isInvalidated && self.isLocationDao($0) }.forEach { self.updateLastSentLocation(dao: $0) }
                self.logProcessedDaos(processedDaos: resolvedProcessedDaos)

                Provider.getOutStoreDataManager().sent(daos: resolvedProcessedDaos.filter { !$0.isInvalidated })

                return ServerResponse.success(true)
            }
    }

    private func logProcessedDaos(processedDaos: [LocusSDKOutStoreDao]) {

        let message = processedDaos.map { dao -> String in
            getBulkUpdateType(dao: dao)?.rawValue ?? ""
        }.joined(separator: ",")
        if processedDaos.count > 0 {
            LocusSDKImplementation.shared.logEvent(tag: LocusSDKLoggingTags.outService, message: "Processed daos \(processedDaos.count) - \(message)", logLevel: .info)
        }
    }

    private func logProcessedFileDaos(processedFileDaos: [LocusSDKOutStoreDao]) {
        let message = processedFileDaos.map { dao -> String in
            dao.entityId ?? ""
        }.joined(separator: ",")
        LocusSDKImplementation.shared.logEvent(tag: LocusSDKLoggingTags.outService, message: "Processed file daos \(processedFileDaos.count) - \(message)", logLevel: .info)
    }

    private func insufficientMessagesInQueue(daos: Results<LocusSDKOutStoreDao>, setting: AsyncCommunicationSetting) -> Bool {
        return daos.count < setting.batchMinCount!
    }

    private func insufficientTimeElapsed(setting: AsyncCommunicationSetting) -> Bool {
        return !AppUtil.isOlderThanSecs(time: NetworkStateManager.lastSuccessTime, seconds: setting.batchUpdatesTimeout!)
    }

    private func isLocationDao(_ dao: LocusSDKOutStoreDao) -> Bool {
        return dao.url.contains("/location") && dao.returnType == nil
    }

    private func updateLastSentLocation(dao: LocusSDKOutStoreDao) {
        if let lastLocation = getLocation(dao: dao) {
            Provider.getDataManager().lastSentLocation = lastLocation
        }
    }

    private func getLocation(dao: LocusSDKOutStoreDao) -> Location? {
        if let location = JsonSerializer.deserialize(string: dao.body, type: LocationUpdateRequestWrapper.self)?.location {
            return location
        }
        return nil
    }

    private func processNonFileDaos(daos: [LocusSDKOutStoreDao]) -> (processedDaos: [LocusSDKOutStoreDao], updates: BulkUpdates) {
        var processedDaos: [LocusSDKOutStoreDao] = []
        var updates: [BulkUpdate] = []

        for dao in daos {
            let (daoIsIncluded, update) = addNonFileUpdates(dao: dao)
            if daoIsIncluded {
                processedDaos.append(dao)
                updates.append(update!)
            }
        }

        return (processedDaos, BulkUpdates(updates: updates))
    }

    private func getBulkUpdateType(dao: LocusSDKOutStoreDao) -> BulkUpdateType? {
        if PathDataExtractor.isLocationUpdate(in: dao.url) {
            return .location
        }
        if PathDataExtractor.isVisitStatusUpdate(in: dao.url) {
            return .visitStatus
        }
        if PathDataExtractor.isTaskStatusUpdate(in: dao.url) {
            return .taskStatus
        }
        if PathDataExtractor.isLineItemStatusUpdate(in: dao.url) {
            return .lineItemTransaction
        }
        if PathDataExtractor.isUserVisitStatusUpdate(in: dao.url) {
            return .userVisitStatus
        }
        if PathDataExtractor.isTourVisitStatusUpdate(in: dao.url) {
            return .tourVisitStatus
        }
        return nil
    }

    private func messageIdFromTimeStamp(date: Date) -> String {
        if #available(iOS 11.0, *) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            return formatter.string(from: date)
        } else {
            let dateFormatter = DateFormatter.iso8601Full
            return dateFormatter.string(from: date)
        }
    }

    private func addNonFileUpdates(dao: LocusSDKOutStoreDao) -> (daoIsIncluded: Bool, update: BulkUpdate?) {

        if isFileUploadResponse(dao: dao) {
            return (false, nil)
        }

        let update = BulkUpdate(updateType: getBulkUpdateType(dao: dao), url: dao.url, payload: dao.body, messageId: String(dao.createdOn!.milliSecondsSinceEpoch), id: messageIdFromTimeStamp(date: dao.createdOn!))

        return (true, update)
    }

    private func isFileUploadResponse(dao: LocusSDKOutStoreDao) -> Bool {
        let returnType: String? = dao.returnType
        return returnType == OutStoreDataManagerConstants.fileUploadReturnType
    }

    class func hasPendingMessages() -> Bool {
        let outStoreDataManager = Provider.getOutStoreDataManager()
        return outStoreDataManager.getAllDaoCount() > 0
    }
}
