import Foundation

/** A latitude, longitude pair */

open class LatLng: Codable {

    public var lat: Double?
    public var lng: Double?
    /** Accuracy of lat,lng in meters. If the lat,lng denotes a certain region instead of the exact address, this field can be used to denote the accuracy of the same. For example, if the lat,lng denotes a region of 2km x 2km, put this value as 2000. A value of 0 or a null value denotes that lat,lng is exact. */
    public var accuracy: Int?

    public init(lat: Double?, lng: Double?, accuracy: Int?) {
        self.lat = lat
        self.lng = lng
        self.accuracy = accuracy
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lat, forKey: "lat")
        try container.encodeIfPresent(lng, forKey: "lng")
        try container.encodeIfPresent(accuracy, forKey: "accuracy")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lat = try container.decodeIfPresent(Double.self, forKey: "lat")
        lng = try container.decodeIfPresent(Double.self, forKey: "lng")
        accuracy = try container.decodeIfPresent(Int.self, forKey: "accuracy")
    }
}
