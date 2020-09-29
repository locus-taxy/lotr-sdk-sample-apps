import Foundation

open class AckMessage: Codable {

    /** Id of the message for which ack is being sent */
    public var messageId: String?
    /** Timestamp when the message was received, in millis since epoch */
    public var receiveTime: Int64?

    public init(messageId: String?, receiveTime: Int64?) {
        self.messageId = messageId
        self.receiveTime = receiveTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(messageId, forKey: "messageId")
        try container.encodeIfPresent(receiveTime, forKey: "receiveTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        messageId = try container.decodeIfPresent(String.self, forKey: "messageId")
        receiveTime = try container.decodeIfPresent(Int64.self, forKey: "receiveTime")
    }
}
