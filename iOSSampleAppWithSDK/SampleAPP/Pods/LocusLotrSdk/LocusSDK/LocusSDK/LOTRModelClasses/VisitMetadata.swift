import Foundation

/** Metadata about visit. This can be used to give hints to the engine to add certain biases. */

open class VisitMetadata: Codable {

    public enum ModelType: String, Codable {
        case homebase = "HOMEBASE"
        case customer = "CUSTOMER"
    }

    public var type: ModelType?

    public init(type: ModelType?) {
        self.type = type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(type, forKey: "type")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        type = try container.decodeIfPresent(ModelType.self, forKey: "type")
    }
}
