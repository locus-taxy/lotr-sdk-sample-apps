import Foundation
import RealmSwift

class PreferenceStoreDao: Object {

    @objc dynamic var id: String?
    @objc dynamic var entity: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: String, entity: String) {
        self.init()
        self.id = id
        self.entity = entity
    }

    class func getDaoObject<T: Codable>(object: T, key: String) -> PreferenceStoreDao {
        return PreferenceStoreDao(id: key, entity: JsonSerializer.serialize(object)!)
    }

    func getObject<T: Codable>(model _: T.Type) -> T {
        return JsonSerializer.deserialize(string: self.entity!, type: T.self)!
    }
}
