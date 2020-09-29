import Foundation

open class VolumeDefinition: Codable {

    public enum Unit: String, Codable {
        case itemCount = "ITEM_COUNT"
        case taskCount = "TASK_COUNT"
        case metersCubic = "METERS_CUBIC"
        case lbhMeters = "LBH_METERS"
    }

    /** Unit for volume. */
    public var unit: Unit?

    public init(unit: Unit?) {
        self.unit = unit
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(unit, forKey: "unit")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        unit = try container.decodeIfPresent(Unit.self, forKey: "unit")
    }
}
