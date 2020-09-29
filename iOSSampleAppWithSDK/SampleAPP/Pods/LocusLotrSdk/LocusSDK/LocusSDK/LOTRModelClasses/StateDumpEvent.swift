import Foundation

/** An event to trigger state dump of a client app. This is used only for debugging purposes. Corresponds to STATE_DUMP control event type */

open class StateDumpEvent: Codable {

    public var unused: String?

    public init(unused: String?) {
        self.unused = unused
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(unused, forKey: "unused")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        unused = try container.decodeIfPresent(String.self, forKey: "unused")
    }
}
