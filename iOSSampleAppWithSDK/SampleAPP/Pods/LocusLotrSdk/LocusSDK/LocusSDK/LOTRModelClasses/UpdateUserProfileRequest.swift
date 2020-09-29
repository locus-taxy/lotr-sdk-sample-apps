import Foundation

/** A request for user&#39;s name change */

open class UpdateUserProfileRequest: Codable {

    /** New name to be updated */
    public var name: String?

    public init(name: String?) {
        self.name = name
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
    }
}
