import Foundation

/** Response of getUnackedMessages API */

open class GetUnackedMessagesResponse: Codable {

    /** List of messages */
    public var messages: [ControlEventWrapper]?

    public init(messages: [ControlEventWrapper]?) {
        self.messages = messages
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(messages, forKey: "messages")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        messages = try container.decodeIfPresent([ControlEventWrapper].self, forKey: "messages")
    }
}
