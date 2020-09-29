import Alamofire
import Foundation
import Moya

class MoyaSession {

    var session: Session?

    init() {
        let evaluator = PublicKeysTrustEvaluator(keys: Bundle.getFrameworkBundle().af.publicKeys, performDefaultValidation: true, validateHost: true)
        let manager = ServerTrustManager(evaluators: ["lotr.locus-api.com": evaluator])
        session = Session(serverTrustManager: manager)
    }
}
