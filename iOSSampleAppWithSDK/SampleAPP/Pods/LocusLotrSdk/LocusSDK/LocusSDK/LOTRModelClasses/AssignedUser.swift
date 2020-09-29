import Foundation

/** A user to whom the task can be assigned */

open class AssignedUser: Codable {

    /** Id of the client who will fulfill the order. Typically, this would be your clientId itself. */
    public var carrierClientId: String?
    /** Id of the delivery person within the above client */
    public var userId: String?

    public init(carrierClientId: String?, userId: String?) {
        self.carrierClientId = carrierClientId
        self.userId = userId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(carrierClientId, forKey: "carrierClientId")
        try container.encodeIfPresent(userId, forKey: "userId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        carrierClientId = try container.decodeIfPresent(String.self, forKey: "carrierClientId")
        userId = try container.decodeIfPresent(String.self, forKey: "userId")
    }
}
