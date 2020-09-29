import Foundation

open class BulkUpdate: Codable {

    public var updateType: BulkUpdateType?
    public var url: String?
    public var payload: String?
    public var messageId: String?
    public var id: String?

    public init(updateType: BulkUpdateType?, url: String?, payload: String?, messageId: String?, id: String?) {
        self.updateType = updateType
        self.url = url
        self.payload = payload
        self.messageId = messageId
        self.id = id
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(updateType, forKey: "updateType")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(payload, forKey: "payload")
        try container.encodeIfPresent(messageId, forKey: "messageId")
        try container.encodeIfPresent(id, forKey: "id")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        updateType = try container.decodeIfPresent(BulkUpdateType.self, forKey: "updateType")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        payload = try container.decodeIfPresent(String.self, forKey: "payload")
        messageId = try container.decodeIfPresent(String.self, forKey: "messageId")
        id = try container.decodeIfPresent(String.self, forKey: "id")
    }
}
