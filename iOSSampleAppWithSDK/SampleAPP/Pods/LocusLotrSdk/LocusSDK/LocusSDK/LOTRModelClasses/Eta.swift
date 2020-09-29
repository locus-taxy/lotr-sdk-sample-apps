import Foundation

/** ETA related information */

open class Eta: Codable {

    /** Time of arrival */
    public var arrivalTime: Date?
    /** Timestamp when this ETA was estimated */
    public var estimatedOn: Date?

    public init(arrivalTime: Date?, estimatedOn: Date?) {
        self.arrivalTime = arrivalTime
        self.estimatedOn = estimatedOn
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(arrivalTime, forKey: "arrivalTime")
        try container.encodeIfPresent(estimatedOn, forKey: "estimatedOn")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        arrivalTime = try container.decodeIfPresent(Date.self, forKey: "arrivalTime")
        estimatedOn = try container.decodeIfPresent(Date.self, forKey: "estimatedOn")
    }
}
