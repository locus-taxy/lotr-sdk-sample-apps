import Foundation

/** Metadata for geocoding of the address */

open class GeocodingMetadata: Codable {

    public var goodness: GeocodingGoodness?

    public init(goodness: GeocodingGoodness?) {
        self.goodness = goodness
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(goodness, forKey: "goodness")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        goodness = try container.decodeIfPresent(GeocodingGoodness.self, forKey: "goodness")
    }
}
