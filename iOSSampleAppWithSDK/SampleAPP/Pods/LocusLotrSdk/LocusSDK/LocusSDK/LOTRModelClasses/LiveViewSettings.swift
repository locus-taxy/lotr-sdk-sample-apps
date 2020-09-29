import Foundation

/** Live view related settings for the client */

open class LiveViewSettings: Codable {

    /** Url for client logo */
    public var logo: String?

    public init(logo: String?) {
        self.logo = logo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(logo, forKey: "logo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        logo = try container.decodeIfPresent(String.self, forKey: "logo")
    }
}
