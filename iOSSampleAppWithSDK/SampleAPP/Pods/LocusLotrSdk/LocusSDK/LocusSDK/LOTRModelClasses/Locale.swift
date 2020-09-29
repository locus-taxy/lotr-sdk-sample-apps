import Foundation

/** Locale of the device, like en_US or fr_FR */

open class Locale: Codable {

    /** Language part of locale, like en or fr */
    public var lang: String?
    /** Country part of locale, like US or FR */
    public var country: String?

    public init(lang: String?, country: String?) {
        self.lang = lang
        self.country = country
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lang, forKey: "lang")
        try container.encodeIfPresent(country, forKey: "country")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lang = try container.decodeIfPresent(String.self, forKey: "lang")
        country = try container.decodeIfPresent(String.self, forKey: "country")
    }
}
