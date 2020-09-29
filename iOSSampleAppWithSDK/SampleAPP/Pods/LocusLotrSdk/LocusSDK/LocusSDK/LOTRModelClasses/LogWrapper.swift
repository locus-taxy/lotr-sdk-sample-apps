import Foundation

open class LogWrapper: Codable {

    public var payload: String?

    public init(payload: String?) {
        self.payload = payload
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(payload, forKey: "payload")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        payload = try container.decodeIfPresent(String.self, forKey: "payload")
    }
}
