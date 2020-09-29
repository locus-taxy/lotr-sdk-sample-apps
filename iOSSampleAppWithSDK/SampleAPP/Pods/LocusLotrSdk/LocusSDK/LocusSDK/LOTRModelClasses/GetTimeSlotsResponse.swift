import Foundation

open class GetTimeSlotsResponse: Codable {

    public var slots: [TimeSlot]?

    public init(slots: [TimeSlot]?) {
        self.slots = slots
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(slots, forKey: "slots")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        slots = try container.decodeIfPresent([TimeSlot].self, forKey: "slots")
    }
}
