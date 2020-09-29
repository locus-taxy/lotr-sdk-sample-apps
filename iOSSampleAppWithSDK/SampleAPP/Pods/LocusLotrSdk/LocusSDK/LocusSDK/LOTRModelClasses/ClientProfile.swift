import Foundation

/** A container for client profile items */

open class ClientProfile: Codable {

    /** Items to be populated on Locus delivery app */
    public var items: [ClientProfileItem]?

    public init(items: [ClientProfileItem]?) {
        self.items = items
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(items, forKey: "items")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        items = try container.decodeIfPresent([ClientProfileItem].self, forKey: "items")
    }
}
