import Foundation

open class BulkUpdates: Codable {

    public var updates: [BulkUpdate]?

    public init(updates: [BulkUpdate]?) {
        self.updates = updates
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(updates, forKey: "updates")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        updates = try container.decodeIfPresent([BulkUpdate].self, forKey: "updates")
    }
}
