import Foundation
import RealmSwift

class LocusSDKOutStoreDao: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var url: String!
    @objc dynamic var method: String!
    @objc dynamic var body: String!
    @objc dynamic var createdOn: Date?
    @objc dynamic var returnType: String?
    @objc dynamic var entityId: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    class func IncrementaID() -> Int {
        let realm = try! Realm()
        if let retNext = realm.objects(LocusSDKOutStoreDao.self).sorted(byKeyPath: "id").first?.id {
            return retNext + 1
        } else {
            return 1
        }
    }
}
