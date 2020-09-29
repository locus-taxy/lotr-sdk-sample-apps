import Foundation
import RealmSwift

/// Authentication Parameters object
public struct AuthParams: Codable {

    /** Client Id */
    let clientId: String?

    /** User Id */
    let userId: String?

    /** Password */
    let password: String?

    /** boolean to indicate if the authentication is at client level */
    let isClientAuth: Bool

    private init(clientId: String?, userId: String?, password: String?, isClientAuth: Bool = false) {
        self.clientId = clientId
        self.userId = userId
        self.password = password
        self.isClientAuth = isClientAuth
    }

    /// get AuthParam Object for client
    ///
    /// - Parameters:
    ///   - clientId: Id of Client
    ///   - password: Token/Password for Client
    /// - Returns: AuthParam onject
    public static func forClient(clientId: String, password: String) -> AuthParams {
        return AuthParams(clientId: clientId, userId: nil, password: password, isClientAuth: true)
    }

    /// get AuthParam Object for User
    ///
    /// - Parameters:
    ///   - clientId: Id of Client
    ///   - userId: Id of User
    ///   - password: Token/Password for User
    /// - Returns: AuthParam Object
    public static func forUser(clientId: String, userId: String, password: String) -> AuthParams {
        return AuthParams(clientId: clientId, userId: userId, password: password, isClientAuth: false)
    }

    private func getAuthString() -> String {
        guard let clientId = clientId, let userId = userId, let password = password else {
            return ""
        }
        if isClientAuth {
            return "\(clientId):\(password)"
        }
        return "\(clientId)/\(userId):\(password)"
    }

    func getbasicAuthHeader() -> [String: String] {

        let authString = getAuthString()
        let authStringEncoded = authString.data(using: String.Encoding.utf8)!
        let basicAuthKey = "Authorization"
        let basicAuthValue = "Basic \(authStringEncoded.base64EncodedString())"
        return [basicAuthKey: basicAuthValue]
    }
}
