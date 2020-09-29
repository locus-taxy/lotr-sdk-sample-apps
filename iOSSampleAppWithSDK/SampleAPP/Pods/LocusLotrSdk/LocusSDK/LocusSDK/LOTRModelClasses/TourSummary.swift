import Foundation

/** Summary of a tour */

open class TourSummary: Codable {

    public var totalTravelDistance: Int?

    public init(totalTravelDistance: Int?) {
        self.totalTravelDistance = totalTravelDistance
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(totalTravelDistance, forKey: "totalTravelDistance")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        totalTravelDistance = try container.decodeIfPresent(Int.self, forKey: "totalTravelDistance")
    }
}
