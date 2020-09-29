import Foundation

/** A container for all events that server will send to client apps. */

open class ControlEventWrapper: Codable {

    public enum ModelType: String, Codable {
        case taskUpdate = "TASK_UPDATE"
        case userUpdate = "USER_UPDATE"
        case stateDump = "STATE_DUMP"
        case configUpdate = "CONFIG_UPDATE"
        case logoutUser = "LOGOUT_USER"
        case tourUpdate = "TOUR_UPDATE"
        case appUpdate = "APP_UPDATE"
    }

    /** An identifier for the event. Client apps should send an ack to server using this id, via ackMessage API. */
    public var id: String?
    /** Type of the message. Corresponds to one of the types of the messages that server can send to the client. Client should use it to decide which object type to deserialize the event into */
    public var type: ModelType?
    /** Timestamp when the message was generated, in millis since epoch */
    public var timestamp: Int64?
    /** Actual event serialized as json */
    public var eventString: String?
    public var tag: String?

    public init(id: String?, type: ModelType?, timestamp: Int64?, eventString: String?, tag: String?) {
        self.id = id
        self.type = type
        self.timestamp = timestamp
        self.eventString = eventString
        self.tag = tag
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(type, forKey: "type")
        try container.encodeIfPresent(timestamp, forKey: "timestamp")
        try container.encodeIfPresent(eventString, forKey: "eventString")
        try container.encodeIfPresent(tag, forKey: "tag")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        type = try container.decodeIfPresent(ModelType.self, forKey: "type")
        timestamp = try container.decodeIfPresent(Int64.self, forKey: "timestamp")
        eventString = try container.decodeIfPresent(String.self, forKey: "eventString")
        tag = try container.decodeIfPresent(String.self, forKey: "tag")
    }
}
