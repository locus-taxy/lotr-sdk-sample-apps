import Foundation
import RealmSwift

protocol OutStoreDataManager {

    func add(url: String, body: String, method: String, returnType: String?, entityId: String?)

    func sent(dao: LocusSDKOutStoreDao)

    func sent(daos: [LocusSDKOutStoreDao])

    func getUnsentFiles() -> [LocusSDKOutStoreDao]

    func getAllDaoCount() -> Int

    func getAllFileDaos() -> Results<LocusSDKOutStoreDao>

    func getAllDaos() -> Results<LocusSDKOutStoreDao>

    func get(clientId: String, taskId: String) -> Results<LocusSDKOutStoreDao>

    func deleteAll()

    func resolve<Confined>(_ reference: ThreadSafeReference<Confined>) -> Confined?
}

struct OutStoreDataManagerConstants {
    static let fileUploadReturnType = "FileUploadResponse"
}
