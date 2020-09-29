import Foundation

open class PasswordMetadata: Codable {

    public var expiryDate: Date?

    public init(expiryDate: Date?) {
        self.expiryDate = expiryDate
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(expiryDate, forKey: "expiryDate")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        expiryDate = try container.decodeIfPresent(Date.self, forKey: "expiryDate")
    }
}
