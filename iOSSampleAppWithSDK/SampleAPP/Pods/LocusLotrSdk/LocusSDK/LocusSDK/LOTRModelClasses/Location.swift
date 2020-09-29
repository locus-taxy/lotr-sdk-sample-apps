import Foundation

/** A location, usually measured via some sensor - GPS, wifi, cell network etc */

open class Location: Codable {

    public enum ModelType: String, Codable {
        case place = "PLACE"
        case droppedPin = "DROPPED_PIN"
    }

    public var lat: Double?
    public var lng: Double?
    /** Name of the place, typically as provided by some Google API - could be Places API */
    public var name: String?
    /** Address of the place, typically as provided by some Google API - could be Places API, Geocoding API etc */
    public var address: String?
    /** For a measured location, the accuracy of the measurement, defined as the radius of 68% confidence, in meters. */
    public var accuracy: Double?
    /** For a measured location, the provider of the location, like, GPS or network etc */
    public var provider: String?
    /** timestamp of when this location fix was obtained, in millis since epoch */
    public var timestamp: Int64?
    /** Measured speed at the location, in meters per second */
    public var speed: Float?
    /** direction of travel, in degrees East of true north */
    public var direction: Float?
    /** Distance that user has travelled so far in reaching this location, within current trip */
    public var distance: Int?
    /** Boolean denoting whether GPS was on at the time of this location fix or not */
    public var gpsEnabled: Bool?
    public var type: ModelType?
    /** Boolean denoting whether this is a valid location. Locus system will decide the validity of location based on accuracy, and harmony with other locations within the current trip */
    public var valid: Bool?

    public init(lat: Double?, lng: Double?, name: String?, address: String?, accuracy: Double?, provider: String?, timestamp: Int64?, speed: Float?, direction: Float?, distance: Int?, gpsEnabled: Bool?, type: ModelType?, valid: Bool?) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.address = address
        self.accuracy = accuracy
        self.provider = provider
        self.timestamp = timestamp
        self.speed = speed
        self.direction = direction
        self.distance = distance
        self.gpsEnabled = gpsEnabled
        self.type = type
        self.valid = valid
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lat, forKey: "lat")
        try container.encodeIfPresent(lng, forKey: "lng")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(address, forKey: "address")
        try container.encodeIfPresent(accuracy, forKey: "accuracy")
        try container.encodeIfPresent(provider, forKey: "provider")
        try container.encodeIfPresent(timestamp, forKey: "timestamp")
        try container.encodeIfPresent(speed, forKey: "speed")
        try container.encodeIfPresent(direction, forKey: "direction")
        try container.encodeIfPresent(distance, forKey: "distance")
        try container.encodeIfPresent(gpsEnabled, forKey: "gpsEnabled")
        try container.encodeIfPresent(type, forKey: "type")
        try container.encodeIfPresent(valid, forKey: "valid")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lat = try container.decodeIfPresent(Double.self, forKey: "lat")
        lng = try container.decodeIfPresent(Double.self, forKey: "lng")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        address = try container.decodeIfPresent(String.self, forKey: "address")
        accuracy = try container.decodeIfPresent(Double.self, forKey: "accuracy")
        provider = try container.decodeIfPresent(String.self, forKey: "provider")
        timestamp = try container.decodeIfPresent(Int64.self, forKey: "timestamp")
        speed = try container.decodeIfPresent(Float.self, forKey: "speed")
        direction = try container.decodeIfPresent(Float.self, forKey: "direction")
        distance = try container.decodeIfPresent(Int.self, forKey: "distance")
        gpsEnabled = try container.decodeIfPresent(Bool.self, forKey: "gpsEnabled")
        type = try container.decodeIfPresent(ModelType.self, forKey: "type")
        valid = try container.decodeIfPresent(Bool.self, forKey: "valid")
    }
}
