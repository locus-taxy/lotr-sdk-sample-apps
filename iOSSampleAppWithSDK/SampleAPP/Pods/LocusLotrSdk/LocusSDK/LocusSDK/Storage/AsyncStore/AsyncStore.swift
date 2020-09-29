import Foundation
import Moya
import RxSwift

struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

class AsyncStore: LocusSDKClient {

    let outStoreDataManager: OutStoreDataManager!

    init(provider: MoyaProvider<LocusSDKService>, outStoreDataManager: OutStoreDataManager) {
        self.outStoreDataManager = outStoreDataManager
        super.init(provider: provider)
    }

    override func request(target: LocusSDKService) -> Observable<ServerResponse<Moya.Response>> {
        return Observable.create { observer -> Disposable in

            var body: String!
            let url = target.baseURL.absoluteString + target.path
            let entityId = self.getEntityId(target: target)
            switch target.task {

                case .uploadMultipart:
                    let filename = PathDataExtractor.getFilename(in: target.path)
                    self.outStoreDataManager.add(url: url, body: filename!, method: target.method.rawValue, returnType: String(describing: FileUploadResponse.self), entityId: entityId)
                    observer.onNext(self.mockSuccess())
                    observer.onCompleted()

                case let .requestJSONEncodable(encodable):
                    body = JsonSerializer.serialize(AnyEncodable(encodable))
                    self.outStoreDataManager.add(url: url, body: body!, method: target.method.rawValue, returnType: nil, entityId: entityId)
                    observer.onNext(self.mockSuccess())
                    observer.onCompleted()

                case let .requestData(data):
                    body = String(data: data, encoding: String.Encoding.utf8)
                    self.outStoreDataManager.add(url: url, body: body!, method: target.method.rawValue, returnType: nil, entityId: entityId)
                    observer.onNext(self.mockSuccess())
                    observer.onCompleted()

                default:
                    observer.onError(LocusSDKErrorInternal.invalidData)
            }

            return Disposables.create()
        }
    }

    fileprivate func mockSuccess() -> ServerResponse<Moya.Response> {
        let data = Moya.Data()
        let response = Moya.Response(statusCode: 200, data: data)
        return ServerResponse.success(response)
    }

    fileprivate func getEntityId(target: LocusSDKService) -> String? {
        switch target {
            case let .login(authParams):
                return "\(authParams.clientId!)/\(authParams.userId!)"
            case let .uploadTaskFile(clientId, taskId, _, _),
                 let .updateTaskStatus(clientId, taskId, _),
                 let .updateVisitStatus(clientId, taskId, _, _),
                 let .updateLineItemTransaction(clientId, taskId, _, _):
                return "\(clientId)\(taskId)"

            default:
                return nil
        }
    }
}
