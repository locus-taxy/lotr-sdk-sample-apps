import Foundation

open class ChecklistPossibleValue: Codable {

    /** identifier of checklist item value */
    public var key: String?
    public var value: String?

    public init(key: String?, value: String?) {
        self.key = key
        self.value = value
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(key, forKey: "key")
        try container.encodeIfPresent(value, forKey: "value")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        key = try container.decodeIfPresent(String.self, forKey: "key")
        value = try container.decodeIfPresent(String.self, forKey: "value")
    }
}
