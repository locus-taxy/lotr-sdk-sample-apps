import Foundation

open class TimeDistancePair: Codable {

    public var distance: Int?
    public var duration: Int?

    public init(distance: Int?, duration: Int?) {
        self.distance = distance
        self.duration = duration
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(distance, forKey: "distance")
        try container.encodeIfPresent(duration, forKey: "duration")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        distance = try container.decodeIfPresent(Int.self, forKey: "distance")
        duration = try container.decodeIfPresent(Int.self, forKey: "duration")
    }
}
