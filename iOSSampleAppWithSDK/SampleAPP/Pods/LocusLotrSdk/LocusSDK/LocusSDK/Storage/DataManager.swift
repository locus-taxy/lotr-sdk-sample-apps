import Foundation
import RxSwift

protocol DataManagerProtocol {

    var authParams: AuthParams? { get set }

    var clientAppConfig: ClientAppConfig? { get set }

    var user: User? { get set }

    var lastSentLocation: Location? { get set }

    func lastSentLocationObservable() -> Observable<Location>?

    var networkState: NetworkState? { get set }
}

class DataManager: DataManagerProtocol {

    let realmHelper: RealmHelper!

    init(_ realmHelper: RealmHelper) {
        self.realmHelper = realmHelper
    }

    func clearStoredData() {
        self.tintColour = nil
        self.realmHelper.delete(for: PreferenceStoreDao.self)
    }

    var authParams: AuthParams? {
        set {
            if let authParam = newValue {
                self.realmHelper.add(PreferenceStoreDao.getDaoObject(object: authParam, key: "authParam"))
                return
            }
            self.realmHelper.delete(for: PreferenceStoreDao.self, with: "authParam")
        }
        get {
            if let authParam = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "authParam") {
                return authParam.getObject(model: AuthParams.self)
            }
            return nil
        }
    }

    var tintColour: UIColor? {
        set {
            if let tintColor = newValue {
                UserDefaults.standard.set(tintColor.toHexString(), forKey: "LocusSDKTintColour")
                return
            }
            UserDefaults.standard.removeObject(forKey: "LocusSDKTintColour")
        }
        get {
            if let tintColour = UserDefaults.standard.object(forKey: "LocusSDKTintColour") {
                return UIColor(hexString: tintColour as! String)
            }
            return UIColor.AppColor.Blue.Azure
        }
    }

    var clientAppConfig: ClientAppConfig? {
        set {
            if let clientAppConfig = newValue {
                self.realmHelper.add(PreferenceStoreDao.getDaoObject(object: clientAppConfig, key: "clientAppConfig"))
                return
            }
            self.realmHelper.delete(for: PreferenceStoreDao.self, with: "clientAppConfig")
        }
        get {
            if let clientAppConfig = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "clientAppConfig") {
                return clientAppConfig.getObject(model: ClientAppConfig.self)
            }
            return nil
        }
    }

    var user: User? {
        set {
            if let user = newValue {
                self.realmHelper.add(PreferenceStoreDao.getDaoObject(object: user, key: "user"))
                return
            }
            self.realmHelper.delete(for: PreferenceStoreDao.self, with: "user")
        }
        get {
            if let user = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "user") {
                return user.getObject(model: User.self)
            }
            return nil
        }
    }

    var lastSentLocation: Location? {
        set {
            if let lastSentLocation = newValue {
                self.realmHelper.add(PreferenceStoreDao.getDaoObject(object: lastSentLocation, key: "lastSentLocation"))
                return
            }
            self.realmHelper.delete(for: PreferenceStoreDao.self, with: "lastSentLocation")
        }
        get {
            if let locationdao = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "lastSentLocation") {
                let location = locationdao.getObject(model: Location.self)
                if Location.isNilLocation(location: location) {
                    return nil
                }
                return location
            }
            return nil
        }
    }

    func lastSentLocationObservable() -> Observable<Location>? {

        if lastSentLocation == nil {
            lastSentLocation = Location.nilLocation()
        }
        if let location = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "lastSentLocation") {
            return Observable.from(object: location).map { dao -> Location in
                dao.getObject(model: Location.self)
            }
        }
        return nil
    }

    var networkState: NetworkState? {
        set {
            if let networkState = newValue {
                self.realmHelper.add(PreferenceStoreDao.getDaoObject(object: networkState, key: "networkState"))
                return
            }
            self.realmHelper.delete(for: PreferenceStoreDao.self, with: "networkState")
        }
        get {
            if let networkState = self.realmHelper.getElement(for: PreferenceStoreDao.self, with: "networkState") {
                return networkState.getObject(model: NetworkState.self)
            }
            return nil
        }
    }
}
