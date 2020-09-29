import Foundation
import Moya
import RxSwift

class LocusSDKClient {

    var disposeBag = DisposeBag()
    var provider: MoyaProvider<LocusSDKService>

    init(provider: MoyaProvider<LocusSDKService>) {
        self.provider = provider
    }

    func request(target: LocusSDKService) -> Observable<ServerResponse<Moya.Response>> {

        return self.provider.rx.request(target)
            .catchError { (_) -> PrimitiveSequence<SingleTrait, Moya.Response> in
                Single.error(LocusSDKError.networkFailure)
            }
            .map { response -> ServerResponse<Moya.Response> in

                let modifiedResponse = self.getModifiedResponse(response)

                switch modifiedResponse {
                    case .success:
                        return modifiedResponse

                    case let .authError(errorType, _):
                        let message = modifiedResponse.errorMessage ?? "Error code: \(errorType.code) Error Type: \(errorType.self)"
                        throw LocusSDKError.authError(message: message)

                    case let .generalError(message):
                        throw LocusSDKError.general(message: message ?? "GENERAL_ERROR")
                }
            }.asObservable()
    }

    private func getModifiedResponse(_ response: Moya.Response) -> ServerResponse<Moya.Response> {
        switch response.statusCode {
            case 200 ... 299:
                return ServerResponse.success(response)

            case 401, 403:
                let errorResponse = JsonSerializer.deserialize(data: response.data, type: SDKError.self)
                let authError = AuthErrorType.getAuthErrorForCode(errorResponse?.errorCode ?? -1)
                NotificationCenter.default.post(name: authError.0, object: ServerResponse<Any>.authError(authError.1, errorResponse?.message))
                return ServerResponse.authError(authError.1, errorResponse?.message)

            default:
                let errorResponse = JsonSerializer.deserialize(data: response.data, type: SDKError.self)
                return ServerResponse.generalError(errorResponse?.message)
        }
    }
}

extension LocusSDKClient: WebService {

    func updateTaskStatus(clientId: String, taskId: String, taskStatus: TaskStatus.Status, checklist: [String: String]?) -> Observable<Task?> {
        let taskStatusObj = TaskStatus(status: taskStatus, triggerTime: Date(), checklistValues: checklist, receiveTime: nil, location: nil, actor: nil, assignedUser: nil)
        return request(target: LocusSDKService.updateTaskStatus(clientId: clientId, taskId: taskId, status: taskStatusObj)).map { response -> Task? in
            JsonSerializer.deserialize(data: response.value!.data, type: Task.self)
        }
    }

    func updateVisitStatus(clientId: String, taskId: String, visitId: String, visitStatus: VisitStatus.Status, checklist: [String: String]?) -> Observable<Task?> {
        let visitStatusObj = VisitStatus(status: visitStatus, triggerTime: Date(), checklistValues: checklist, receiveTime: nil, location: nil, actor: nil, assignedUser: nil)
        return request(target: LocusSDKService.updateVisitStatus(clientId: clientId, taskId: taskId, visitId: visitId, status: visitStatusObj)).map { response -> Task? in
            JsonSerializer.deserialize(data: response.value!.data, type: Task.self)
        }
    }

    func updateTourStatus(clientId: String, tourId: String, visitId: String, visitStatus: VisitStatus.Status, checklist: [String: String]?) -> Observable<Task?> {
        let visitStatusObj = VisitStatus(status: visitStatus, triggerTime: Date(), checklistValues: checklist, receiveTime: nil, location: nil, actor: nil, assignedUser: nil)
        return request(target: .updateTourStatus(clientId: clientId, tourId: tourId, visitId: visitId, status: visitStatusObj)).map { response -> Task? in
            JsonSerializer.deserialize(data: response.value!.data, type: Task.self)
        }
    }

    func updateLineItemTransaction(clientId: String, taskId: String, visitId: String, lineItems: [LineItemTransactionStatus]?) -> Observable<Task?> {
        return request(target: LocusSDKService.updateLineItemTransaction(clientId: clientId, taskId: taskId, visitId: visitId, lineItems: lineItems)).map { response -> Task? in
            JsonSerializer.deserialize(data: response.value!.data, type: Task.self)
        }
    }

    func uploadFile(clientId: String, taskId: String, filename: String, data: Data) -> Observable<FileUploadResponse?> {
        return request(target: LocusSDKService.uploadTaskFile(clientId: clientId, taskId: taskId, filename: filename, data: data)).map { response -> FileUploadResponse? in
            JsonSerializer.deserialize(data: response.value!.data, type: FileUploadResponse.self)
        }
    }

    func updateLocation(clientId: String, userId: String, location: Location) -> Observable<Bool> {
        return request(target: .updateLocation(clientId: clientId, userId: userId, location: location)).map { response -> Bool in
            response.isSuccess
        }
    }

    func bulk(clientId _: String, userId _: String, bulkUpdates: BulkUpdates) -> Observable<Bool> {
        let dataManager = Provider.getDataManager()
        return request(target: LocusSDKService.bulkUpdates(clientId: (dataManager.user?.clientId!)!, userId: dataManager.user!.userId!, bulkUpdates: bulkUpdates)).map { response -> Bool in
            response.isSuccess
        }
    }

    func login(authParams authParam: AuthParams) -> Observable<SdkInitializationResponse?> {

        return request(target: LocusSDKService.login(authParams: authParam)).map { response -> SdkInitializationResponse? in
            JsonSerializer.deserialize(data: response.value!.data, type: SdkInitializationResponse.self)
        }
    }
}
