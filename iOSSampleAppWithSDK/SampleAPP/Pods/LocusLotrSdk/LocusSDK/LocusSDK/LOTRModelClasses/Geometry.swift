import Foundation

/** Properties related to the geometry of the place. */

open class Geometry: Codable {

    /** Coordinates for the location */
    public var latLng: LatLng?

    public init(latLng: LatLng?) {
        self.latLng = latLng
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(latLng, forKey: "latLng")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        latLng = try container.decodeIfPresent(LatLng.self, forKey: "latLng")
    }
}
