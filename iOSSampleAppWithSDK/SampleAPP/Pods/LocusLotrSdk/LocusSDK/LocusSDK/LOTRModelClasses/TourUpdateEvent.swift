import Foundation

/** Event denoting an update to tours */

open class TourUpdateEvent: Codable {

    /** Date of the tour which has been updated */
    public var tourDate: String?
    /** Timestamp for when the event was triggered, in UTC using the standard ISO 8601 format */
    public var timestamp: Date?

    public init(tourDate: String?, timestamp: Date?) {
        self.tourDate = tourDate
        self.timestamp = timestamp
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(tourDate, forKey: "tourDate")
        try container.encodeIfPresent(timestamp, forKey: "timestamp")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        tourDate = try container.decodeIfPresent(String.self, forKey: "tourDate")
        timestamp = try container.decodeIfPresent(Date.self, forKey: "timestamp")
    }
}
