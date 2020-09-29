import Foundation

/** A persons token for login */

open class UserAuthToken: Codable {

    /** Id of the client who added this user */
    public var clientId: String?
    /** Id of the user that client knows */
    public var userId: String?
    /** Token of the user */
    public var token: String?

    public init(clientId: String?, userId: String?, token: String?) {
        self.clientId = clientId
        self.userId = userId
        self.token = token
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(userId, forKey: "userId")
        try container.encodeIfPresent(token, forKey: "token")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        userId = try container.decodeIfPresent(String.self, forKey: "userId")
        token = try container.decodeIfPresent(String.self, forKey: "token")
    }
}
