import Foundation

/** A list of volume exchanges */

open class Volumes: Codable {

    /** List of volume exchanges */
    public var volumes: [Volume]?

    public init(volumes: [Volume]?) {
        self.volumes = volumes
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(volumes, forKey: "volumes")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        volumes = try container.decodeIfPresent([Volume].self, forKey: "volumes")
    }
}
