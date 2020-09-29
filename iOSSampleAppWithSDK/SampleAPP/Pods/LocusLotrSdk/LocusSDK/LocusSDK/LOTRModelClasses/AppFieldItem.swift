import Foundation

open class AppFieldItem: Codable {

    public enum Format: String, Codable {
        case url = "URL"
        case text = "TEXT"
    }

    /** String representation of the item, to be displayed on the app */
    public var item: String?
    /**  Format for the item. URL - Url that can be opened as web view on app  TEXT - Static text that can be displayed on the app (e.g. any custom notes)  */
    public var format: Format?
    /** Extra properties required depending on the type. For URL, a key \&quot;url\&quot; should be provided with the url to open. For TEXT, a key \&quot;text\&quot; should be provided with actuall text that needs to be displayed. */
    public var additionalValues: [String: String]?

    public init(item: String?, format: Format?, additionalValues: [String: String]?) {
        self.item = item
        self.format = format
        self.additionalValues = additionalValues
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(item, forKey: "item")
        try container.encodeIfPresent(format, forKey: "format")
        try container.encodeIfPresent(additionalValues, forKey: "additionalValues")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        item = try container.decodeIfPresent(String.self, forKey: "item")
        format = try container.decodeIfPresent(Format.self, forKey: "format")
        additionalValues = try container.decodeIfPresent([String: String].self, forKey: "additionalValues")
    }
}
