import Foundation

/** A resource can be any object present with the delivery person. For example, the amount of money they have. Each resource puts a constraint on the task assignment. A resource will apply a constraint, if and only if ResourceLimit for the resource has been defined for the delivery person. */

open class Resource: Codable {

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
    /** Value of the resource. */
    public var value: Double?
    public var exchangeType: ResourceExchangeType?

    public init(name: String?, unit: Unit?, value: Double?, exchangeType: ResourceExchangeType?) {
        self.name = name
        self.unit = unit
        self.value = value
        self.exchangeType = exchangeType
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(unit, forKey: "unit")
        try container.encodeIfPresent(value, forKey: "value")
        try container.encodeIfPresent(exchangeType, forKey: "exchangeType")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        unit = try container.decodeIfPresent(Unit.self, forKey: "unit")
        value = try container.decodeIfPresent(Double.self, forKey: "value")
        exchangeType = try container.decodeIfPresent(ResourceExchangeType.self, forKey: "exchangeType")
    }
}
