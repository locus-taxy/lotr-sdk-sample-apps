import Foundation

/** ETA related information */

open class MinimalEta: Codable {

    /** Time of arrival */
    public var arrivalTime: Date?

    public init(arrivalTime: Date?) {
        self.arrivalTime = arrivalTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(arrivalTime, forKey: "arrivalTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        arrivalTime = try container.decodeIfPresent(Date.self, forKey: "arrivalTime")
    }
}
