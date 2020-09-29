import Foundation

/** Status of the tour */

open class DetailedTourStatus: Codable {

    public var status: TourStatus?
    /** Time when the status update was triggered on the client side */
    public var triggerTime: Date?

    public init(status: TourStatus?, triggerTime: Date?) {
        self.status = status
        self.triggerTime = triggerTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(triggerTime, forKey: "triggerTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decodeIfPresent(TourStatus.self, forKey: "status")
        triggerTime = try container.decodeIfPresent(Date.self, forKey: "triggerTime")
    }
}
