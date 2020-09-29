import Foundation

/** A unique id for the user */

open class UserId: Codable {

    public var clientId: String?
    public var userId: String?

    public init(clientId: String?, userId: String?) {
        self.clientId = clientId
        self.userId = userId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(userId, forKey: "userId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        userId = try container.decodeIfPresent(String.self, forKey: "userId")
    }
}
