import Foundation

/** A time slot for an event. */

open class TimeSlot: Codable {

    /** Start time of the slot, in UTC using the standard ISO 8601 format */
    public var start: Date?
    /** End time of the slot, in UTC using the standard ISO 8601 format */
    public var end: Date?

    public init(start: Date?, end: Date?) {
        self.start = start
        self.end = end
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(start, forKey: "start")
        try container.encodeIfPresent(end, forKey: "end")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        start = try container.decodeIfPresent(Date.self, forKey: "start")
        end = try container.decodeIfPresent(Date.self, forKey: "end")
    }
}
