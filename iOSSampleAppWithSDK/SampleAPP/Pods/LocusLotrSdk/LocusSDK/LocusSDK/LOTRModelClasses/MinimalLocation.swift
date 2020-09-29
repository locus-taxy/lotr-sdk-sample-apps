import Foundation

/** A location, usually measured via some sensor - GPS, wifi, cell network etc */

open class MinimalLocation: Codable {

    public var lat: Double?
    public var lng: Double?
    /** For a measured location, the accuracy of the measurement, defined as the radius of circle of 68% confidence, in meters. */
    public var accuracy: Double?
    /** timestamp of when this location fix was obtained, in millis since epoch */
    public var timestamp: Int64?
    /** Distance that user has travelled so far in reaching this location, within current trip */
    public var distance: Int?

    public init(lat: Double?, lng: Double?, accuracy: Double?, timestamp: Int64?, distance: Int?) {
        self.lat = lat
        self.lng = lng
        self.accuracy = accuracy
        self.timestamp = timestamp
        self.distance = distance
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lat, forKey: "lat")
        try container.encodeIfPresent(lng, forKey: "lng")
        try container.encodeIfPresent(accuracy, forKey: "accuracy")
        try container.encodeIfPresent(timestamp, forKey: "timestamp")
        try container.encodeIfPresent(distance, forKey: "distance")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lat = try container.decodeIfPresent(Double.self, forKey: "lat")
        lng = try container.decodeIfPresent(Double.self, forKey: "lng")
        accuracy = try container.decodeIfPresent(Double.self, forKey: "accuracy")
        timestamp = try container.decodeIfPresent(Int64.self, forKey: "timestamp")
        distance = try container.decodeIfPresent(Int.self, forKey: "distance")
    }
}
