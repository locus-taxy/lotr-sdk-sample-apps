import Foundation
import RealmSwift

class RealmHelper {

    // Can't make it a constant because of the use of self in migration closure
    var realm: Realm!

    func setup() {

        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in self.handleMigrations(migration: migration, oldVersion: oldSchemaVersion) }
        )

        Realm.Configuration.defaultConfiguration = config

        realm = try! Realm()
    }

    func add(_ object: Object) {
        try! safeWrite {
            // Use update: true only if the object has a primaryKey
            realm.add(object, update: .all)
        }
    }

    func addAll(_ objects: [Object]) {
        try! safeWrite {
            // Use update: true only if the object has a primaryKey
            realm.add(objects, update: .all)
        }
    }

    func getElement<Element: Object>(for model: Element.Type, with id: String) -> Element? {
        return realm.object(ofType: model.self, forPrimaryKey: id)
    }

    func getAll<Element: Object>(for model: Element.Type) -> Results<Element> {
        return realm.objects(model.self)
    }

    func getAll<Element: Object>(for model: Element.Type, with predicate: NSPredicate, sortBy: [SortDescriptor] = []) -> Results<Element> {
        return getAll(for: model).filter(predicate).sorted(by: sortBy)
    }

    func delete<Element: Object>(for model: Element.Type) {
        try! safeWrite {
            let results = realm.objects(model.self)
            realm.delete(results)
        }
    }

    func delete<Element: Object>(for model: Element.Type, with id: String) {
        try! safeWrite {
            if let element = realm.object(ofType: model.self, forPrimaryKey: id) {
                realm.delete(element)
            }
        }
    }

    func delete<Element: Object>(for model: Element.Type, with predicate: NSPredicate) {
        try! safeWrite {
            let results = realm.objects(model.self).filter(predicate)
            realm.delete(results)
        }
    }

    func deleteAll() {
        try! safeWrite {
            realm.deleteAll()
        }
    }

    func inTransaction(_ block: () throws -> Void) {
        try! realm.write {
            try block()
        }
    }

    func safeWrite(_ block: () throws -> Void) throws {
        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }

    func handleMigrations(migration _: Migration, oldVersion _: UInt64) {
        // Handle Migrations in the future
    }
}
