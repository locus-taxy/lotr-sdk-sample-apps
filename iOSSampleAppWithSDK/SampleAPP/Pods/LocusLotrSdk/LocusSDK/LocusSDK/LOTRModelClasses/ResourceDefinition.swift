import Foundation

open class ResourceDefinition: Codable {

    public enum Unit: String, Codable {
        case count = "COUNT"
        case seconds = "SECONDS"
        case meters = "METERS"
        case kg = "KG"
        case unit = "UNIT"
    }

    /** Name of a resource. This should be a unique value within a task. Example values are - CASH. */
    public var name: String?
    /** Unit for a resource. */
    public var unit: Unit?

    public init(name: String?, unit: Unit?) {
        self.name = name
        self.unit = unit
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(unit, forKey: "unit")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        unit = try container.decodeIfPresent(Unit.self, forKey: "unit")
    }
}
