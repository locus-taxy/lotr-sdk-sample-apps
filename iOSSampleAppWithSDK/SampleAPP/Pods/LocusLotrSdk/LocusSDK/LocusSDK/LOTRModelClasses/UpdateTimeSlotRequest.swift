import Foundation

open class UpdateTimeSlotRequest: Codable {

    public var slot: TimeSlot?
    /** Boolean denoting that the task should not be acutally updated; instead just the expected output is returned. Default value is false. */
    public var dryRun: Bool?

    public init(slot: TimeSlot?, dryRun: Bool?) {
        self.slot = slot
        self.dryRun = dryRun
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(slot, forKey: "slot")
        try container.encodeIfPresent(dryRun, forKey: "dryRun")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        slot = try container.decodeIfPresent(TimeSlot.self, forKey: "slot")
        dryRun = try container.decodeIfPresent(Bool.self, forKey: "dryRun")
    }
}
