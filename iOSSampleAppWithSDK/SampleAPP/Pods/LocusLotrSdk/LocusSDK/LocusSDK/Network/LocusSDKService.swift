import Foundation
import Moya

enum LocusSDKService {

    case login(authParams: AuthParams)

    case bulkUpdates(clientId: String, userId: String, bulkUpdates: BulkUpdates)

    case updateLocation(clientId: String, userId: String, location: Location)

    case uploadTaskFile(clientId: String, taskId: String, filename: String, data: Data)

    case updateTaskStatus(clientId: String, taskId: String, status: TaskStatus)

    case updateVisitStatus(clientId: String, taskId: String, visitId: String, status: VisitStatus)

    case updateTourStatus(clientId: String, tourId: String, visitId: String, status: VisitStatus)

    case updateLineItemTransaction(clientId: String, taskId: String, visitId: String, lineItems: [LineItemTransactionStatus]?)
}

extension LocusSDKService: Moya.TargetType {

    var baseURL: URL {
        switch self {
            case .login(_), .bulkUpdates(_, _, _), .updateLocation(_, _, _), .updateTaskStatus(_, _, _), .updateVisitStatus(_, _, _, _), .updateTourStatus(_, _, _, _), .updateLineItemTransaction:
                return URL(string: SERVER_URL)!
            case .uploadTaskFile(clientId: _, taskId: _, filename: _, data: _):
                return URL(string: TAXY_SERVER_URL)!
        }
    }

    var path: String {
        switch self {

            case let .login(authParam):
                return userPath(clientId: authParam.clientId!, userId: authParam.userId!, suffix: "sdkInitData")

            case let .bulkUpdates(clientId, userId, _):
                return userPath(clientId: clientId, userId: userId, suffix: "bulk")

            case let .updateLocation(clientId, userId, _):
                return userPath(clientId: clientId, userId: userId, suffix: "location")

            case let .uploadTaskFile(clientId, taskId, filename, _):
                return LocusSDKService.filePath(clientId: clientId, taskId: taskId, filename: filename)

            case let .updateTaskStatus(clientId, taskId, _):
                return LocusSDKService.taskPath(clientId: clientId, taskId: taskId, suffix: "status")

            case let .updateVisitStatus(clientId, taskId, visitId, _):
                return visitPath(clientId: clientId, taskId: taskId, visitId: visitId, suffix: "status")

            case let .updateTourStatus(clientId, tourId, visitId, _):
                return tourVisitPath(clientId: clientId, tourId: tourId, visitId: visitId, suffix: "status")

            case let .updateLineItemTransaction(clientId, taskId, visitId, _):
                return visitPath(clientId: clientId, taskId: taskId, visitId: visitId, suffix: "lineitemtransaction")
        }
    }

    private func userPath(clientId: String, userId: String, suffix: String = "") -> String {
        return "/client/\(clientId)/user/\(userId)/\(suffix)"
    }

    private func tourPath(clientId: String, tourId: String, suffix: String = "") -> String {
        return "/client/\(clientId)/tour/\(tourId)/\(suffix)"
    }

    private static func taskPath(clientId: String, taskId: String, suffix: String = "") -> String {
        return "/client/\(clientId)/task/\(taskId)/\(suffix)"
    }

    private func visitPath(clientId: String, taskId: String, visitId: String, suffix: String = "") -> String {
        return "\(LocusSDKService.taskPath(clientId: clientId, taskId: taskId))visit/\(visitId)/\(suffix)"
    }

    private func tourVisitPath(clientId: String, tourId: String, visitId: String, suffix: String = "") -> String {
        return "\(tourPath(clientId: clientId, tourId: tourId))visit/\(visitId)/\(suffix)"
    }

    private static func filePath(clientId: String, taskId: String, filename: String) -> String {
        return LocusSDKService.taskPath(clientId: clientId, taskId: taskId, suffix: "file/\(filename)")
    }

    static func fileUploadUrl(task: Task, filename: String) -> String {
        return TAXY_SERVER_URL + LocusSDKService.filePath(clientId: task.clientId!, taskId: task.taskId!, filename: filename)
    }

    var method: Moya.Method {
        switch self {
            case .login(_), .bulkUpdates(_, _, _), .updateLocation(_, _, _), .uploadTaskFile(_, _, _, _), .updateTaskStatus(_, _, _), .updateVisitStatus(_, _, _, _), .updateTourStatus(_, _, _, _), .updateLineItemTransaction:
                return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Moya.Task {
        switch self {
            case .login:
                let body = SdkInitRequest(deviceInfo: DeviceInfoProvider.getDeviceInfo(), dryRun: false)
                return requestData(body: body)

            case let .bulkUpdates(_, _, bulkUpdates):
                return requestData(body: bulkUpdates)

            case let .updateLocation(_, _, location):
                return requestData(body: Location.getLocationUpdateRequest(location: location))

            case let .uploadTaskFile(_, _, filename, data):
                let formData = MultipartFormData(provider: .data(data), name: "file", fileName: "\(filename).jpg", mimeType: data.mimeType)
                return .uploadMultipart([formData])

            case let .updateTaskStatus(_, _, taskStatus):
                let status = TaskStatusRequest.Status(rawValue: (taskStatus.status?.rawValue)!)
                let body = TaskStatusRequest(status: status, triggerTime: taskStatus.triggerTime, checklistValues: taskStatus.checklistValues)
                return requestData(body: body)

            case let .updateVisitStatus(_, _, _, visitStatus):
                let status = VisitStatusRequest.Status(rawValue: visitStatus.status!.rawValue)
                let body = VisitStatusRequest(status: status, triggerTime: visitStatus.triggerTime, checklistValues: visitStatus.checklistValues)
                return requestData(body: body)

            case let .updateTourStatus(_, _, _, visitStatus):
                let status = VisitStatusRequest.Status(rawValue: visitStatus.status!.rawValue)
                let body = VisitStatusRequest(status: status, triggerTime: visitStatus.triggerTime, checklistValues: visitStatus.checklistValues)
                return requestData(body: body)

            case let .updateLineItemTransaction(_, _, _, lineItems):
                let body = UpdateLineItemTransactionRequest(lineItemsTransactionStatus: lineItems)
                return requestData(body: body)
        }
    }

    var headers: [String: String]? {

        let requestHeaders = ["Content-Type": "application/json",
                              "x-app-type": "iOS-lotr-sdk",
                              "x-version-name": AppUtil.getAppVersion(),
                              "Device-Id": DeviceInfoProvider.getDeviceInfo().deviceId!]
        switch self {

            case let .login(authParams):
                let authHeaders = authParams.getbasicAuthHeader()
                return authHeaders + requestHeaders

            default:
                if let authHeaders = Provider.getDataManager().authParams?.getbasicAuthHeader() {
                    return authHeaders + requestHeaders
                }
                return requestHeaders
        }
    }

    // Moya .requestJSONEncodable doesn't handle dates properly
    func requestData<T: Encodable>(body: T) -> Moya.Task {
        let data = JsonSerializer.serialize(body)?.data(using: .utf8)
        return .requestData(data!)
    }
}
