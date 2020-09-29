import Foundation
import RealmSwift

class RealmBasedOutStoreDataManager: OutStoreDataManager {

    let realmHelper: RealmHelper!

    init(_ realmHelper: RealmHelper) {
        self.realmHelper = realmHelper
    }

    func add(url: String, body: String, method: String, returnType: String?, entityId: String?) {
        let dao = transform(url: url, body: body, method: method, returnType: returnType, entityId: entityId)
        realmHelper.add(dao)
        OutService.shared.trigger(forceTransmit: false)
    }

    func sent(dao: LocusSDKOutStoreDao) {

        let timeStampPredicate = NSPredicate(format: "(%K == %@)", #keyPath(LocusSDKOutStoreDao.createdOn), dao.createdOn! as NSDate)

        realmHelper.delete(for: LocusSDKOutStoreDao.self, with: timeStampPredicate)
    }

    func sent(daos: [LocusSDKOutStoreDao]) {

        var createOnStrings: [NSDate] = []

        daos.forEach { dao in
            createOnStrings.append(dao.createdOn! as NSDate)
        }

        let timeStampPredicate = NSPredicate(format: "(%K IN %@)", #keyPath(LocusSDKOutStoreDao.createdOn), createOnStrings)

        realmHelper.delete(for: LocusSDKOutStoreDao.self, with: timeStampPredicate)
    }

    func getUnsentFiles() -> [LocusSDKOutStoreDao] {

        let filePredicate = NSPredicate(format: "(%K == %@)", #keyPath(LocusSDKOutStoreDao.returnType), OutStoreDataManagerConstants.fileUploadReturnType)

        let sortOnCreatedOn = SortDescriptor(keyPath: #keyPath(LocusSDKOutStoreDao.createdOn))

        return realmHelper.getAll(for: LocusSDKOutStoreDao.self, with: filePredicate, sortBy: [sortOnCreatedOn]).toArray()
    }

    func getAllDaoCount() -> Int {
        return realmHelper.getAll(for: LocusSDKOutStoreDao.self).count
    }

    func getAllFileDaos() -> Results<LocusSDKOutStoreDao> {

        let filePredicate = NSPredicate(format: "(%K == %@)", #keyPath(LocusSDKOutStoreDao.returnType), OutStoreDataManagerConstants.fileUploadReturnType)

        let sortOnCreatedOn = SortDescriptor(keyPath: #keyPath(LocusSDKOutStoreDao.createdOn))

        let results = realmHelper.getAll(for: LocusSDKOutStoreDao.self, with: filePredicate, sortBy: [sortOnCreatedOn])

        return results
    }

    func getAllDaos() -> Results<LocusSDKOutStoreDao> {

        let results = realmHelper.getAll(for: LocusSDKOutStoreDao.self)

        return results
    }

    func get(clientId: String, taskId: String) -> Results<LocusSDKOutStoreDao> {

        // Using id for primary key usage
        let idPredicate = NSPredicate(format: "(%K == %@)", #keyPath(LocusSDKOutStoreDao.entityId), "\(clientId)/\(taskId)")
        let results = realmHelper.getAll(for: LocusSDKOutStoreDao.self, with: idPredicate)

        return results
    }

    func deleteAll() {
        realmHelper.delete(for: LocusSDKOutStoreDao.self)
    }

    func resolve<Confined>(_ reference: ThreadSafeReference<Confined>) -> Confined? where Confined: ThreadConfined {
        return realmHelper.realm.resolve(reference)
    }

    // MARK: Helpers

    func transform(url: String, body: String, method: String, returnType: String?, entityId: String?) -> LocusSDKOutStoreDao {

        let dao = LocusSDKOutStoreDao()
        dao.id = LocusSDKOutStoreDao.IncrementaID()
        dao.url = url
        dao.body = body
        dao.method = method
        dao.returnType = returnType
        dao.entityId = entityId
        dao.createdOn = Date()
        return dao
    }
}
