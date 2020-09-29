import Foundation

/** Summary for a visit */

open class VisitSummary: Codable {

    /** Amount of time (in seconds)by which SLA has been breached. */
    public var tardiness: Int?
    public var actualTravelPair: TimeDistancePair?

    public init(tardiness: Int?, actualTravelPair: TimeDistancePair?) {
        self.tardiness = tardiness
        self.actualTravelPair = actualTravelPair
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(tardiness, forKey: "tardiness")
        try container.encodeIfPresent(actualTravelPair, forKey: "actualTravelPair")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        tardiness = try container.decodeIfPresent(Int.self, forKey: "tardiness")
        actualTravelPair = try container.decodeIfPresent(TimeDistancePair.self, forKey: "actualTravelPair")
    }
}
