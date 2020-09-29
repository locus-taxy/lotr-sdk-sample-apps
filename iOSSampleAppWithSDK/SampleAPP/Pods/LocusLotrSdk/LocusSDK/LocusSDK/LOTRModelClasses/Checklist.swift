import Foundation

/** A list of checklist items */

open class Checklist: Codable {

    /** Status to which this checklist needs to apply */
    public var status: String?
    public var items: [ChecklistItem]?

    public init(status: String?, items: [ChecklistItem]?) {
        self.status = status
        self.items = items
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(items, forKey: "items")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decodeIfPresent(String.self, forKey: "status")
        items = try container.decodeIfPresent([ChecklistItem].self, forKey: "items")
    }
}
