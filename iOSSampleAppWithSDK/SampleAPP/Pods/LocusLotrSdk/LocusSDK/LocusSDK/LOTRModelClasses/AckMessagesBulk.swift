import Foundation

open class AckMessagesBulk: Codable {

    public var messages: [AckMessage]?
    /** Timestamp when the message was received, in millis since epoch */
    public var receiveTime: Int64?

    public init(messages: [AckMessage]?, receiveTime: Int64?) {
        self.messages = messages
        self.receiveTime = receiveTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(messages, forKey: "messages")
        try container.encodeIfPresent(receiveTime, forKey: "receiveTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        messages = try container.decodeIfPresent([AckMessage].self, forKey: "messages")
        receiveTime = try container.decodeIfPresent(Int64.self, forKey: "receiveTime")
    }
}
