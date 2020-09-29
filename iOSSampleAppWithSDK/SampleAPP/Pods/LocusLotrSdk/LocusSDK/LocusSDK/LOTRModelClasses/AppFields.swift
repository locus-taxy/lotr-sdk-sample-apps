import Foundation

/** Container for values that are required specifically for rendering on the FE app. */

open class AppFields: Codable {

    public var items: [AppFieldItem]?

    public init(items: [AppFieldItem]?) {
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

        items = try container.decodeIfPresent([AppFieldItem].self, forKey: "items")
    }
}
