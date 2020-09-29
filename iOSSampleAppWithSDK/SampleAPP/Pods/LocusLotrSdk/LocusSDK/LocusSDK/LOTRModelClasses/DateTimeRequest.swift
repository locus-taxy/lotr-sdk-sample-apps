import Foundation

/** Datetime request */

open class DateTimeRequest: Codable {

    /** Device timestamp in UTC using the standard ISO 8601 format */
    public var timestamp: Date?

    public init(timestamp: Date?) {
        self.timestamp = timestamp
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(timestamp, forKey: "timestamp")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        timestamp = try container.decodeIfPresent(Date.self, forKey: "timestamp")
    }
}
