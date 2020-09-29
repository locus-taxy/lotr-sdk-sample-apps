import Foundation
import Moya

class Provider {

    #if DEBUG
        static let moyaProvider = MoyaProvider<LocusSDKService>(session: MoyaSession().session!, plugins: [NetworkLoggerPlugin()])
    #else
        static let moyaProvider = MoyaProvider<LocusSDKService>(session: MoyaSession().session!, plugins: [])
    #endif

    class func getLocusSDKClient() -> LocusSDKClient {
        return LocusSDKClient(provider: moyaProvider)
    }

    class func getAsyncStore() -> LocusSDKClient {
        return AsyncStore(provider: moyaProvider, outStoreDataManager: getOutStoreDataManager())
    }

    class func getOutStoreDataManager() -> OutStoreDataManager {
        let helper = RealmHelper()
        helper.setup()
        return RealmBasedOutStoreDataManager(helper)
    }

    class func getDataManager() -> DataManager {
        let helper = RealmHelper()
        helper.setup()
        return DataManager(helper)
    }
}
