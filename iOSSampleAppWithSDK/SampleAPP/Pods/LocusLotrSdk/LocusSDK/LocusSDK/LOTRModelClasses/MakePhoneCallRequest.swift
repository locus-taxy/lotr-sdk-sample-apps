import Foundation

/** Make a request for a cloud telephony phone call */

open class MakePhoneCallRequest: Codable {

    /** complete id of a user or personnel to be called */
    public var userId: String?

    public init(userId: String?) {
        self.userId = userId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(userId, forKey: "userId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        userId = try container.decodeIfPresent(String.self, forKey: "userId")
    }
}
