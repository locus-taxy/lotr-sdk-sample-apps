import Foundation

/** The location details of the particular location. */

open class LocationDetails: Codable {

    /** An identifier for the location. */
    public var id: String?
    /** Name of the location. */
    public var name: String?
    /** A Boolean that tells whether the location is verified. */
    public var verified: Bool?

    public init(id: String?, name: String?, verified: Bool?) {
        self.id = id
        self.name = name
        self.verified = verified
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(verified, forKey: "verified")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        verified = try container.decodeIfPresent(Bool.self, forKey: "verified")
    }
}
