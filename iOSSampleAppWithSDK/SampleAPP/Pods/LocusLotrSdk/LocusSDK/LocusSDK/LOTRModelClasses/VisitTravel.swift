import Foundation

/** Travel from previous visit to current visit */

open class VisitTravel: Codable {

    public var timeDistancePair: TimeDistancePair?
    public var polyline: String?

    public init(timeDistancePair: TimeDistancePair?, polyline: String?) {
        self.timeDistancePair = timeDistancePair
        self.polyline = polyline
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(timeDistancePair, forKey: "timeDistancePair")
        try container.encodeIfPresent(polyline, forKey: "polyline")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        timeDistancePair = try container.decodeIfPresent(TimeDistancePair.self, forKey: "timeDistancePair")
        polyline = try container.decodeIfPresent(String.self, forKey: "polyline")
    }
}
