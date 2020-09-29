import Foundation

/** Volume of an item */

open class Volume: Codable {

    public enum Unit: String, Codable {
        case itemCount = "ITEM_COUNT"
        case taskCount = "TASK_COUNT"
        case metersCubic = "METERS_CUBIC"
        case lbhMeters = "LBH_METERS"
    }

    /** Unit for volume. */
    public var unit: Unit?
    /** Value of the volume in the given unit. For most cases, this will be a number. For LBH_METERS, this will be a string containing comma separated length, breadth and height, each in meters */
    public var value: String?
    public var exchangeType: ResourceExchangeType?

    public init(unit: Unit?, value: String?, exchangeType: ResourceExchangeType?) {
        self.unit = unit
        self.value = value
        self.exchangeType = exchangeType
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(unit, forKey: "unit")
        try container.encodeIfPresent(value, forKey: "value")
        try container.encodeIfPresent(exchangeType, forKey: "exchangeType")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        unit = try container.decodeIfPresent(Unit.self, forKey: "unit")
        value = try container.decodeIfPresent(String.self, forKey: "value")
        exchangeType = try container.decodeIfPresent(ResourceExchangeType.self, forKey: "exchangeType")
    }
}
