import Foundation

/** A list of resource exchanges */

open class Resources: Codable {

    /** List of resource exchanges */
    public var resources: [Resource]?

    public init(resources: [Resource]?) {
        self.resources = resources
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(resources, forKey: "resources")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        resources = try container.decodeIfPresent([Resource].self, forKey: "resources")
    }
}
