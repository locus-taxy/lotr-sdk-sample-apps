import Foundation

/** Contact point at a visit location. */

open class ContactPoint: Codable {

    /** Name of contact */
    public var name: String?
    /** Number for contact person */
    public var number: String?
    /** Email id of contact */
    public var email: String?

    public init(name: String?, number: String?, email: String?) {
        self.name = name
        self.number = number
        self.email = email
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(number, forKey: "number")
        try container.encodeIfPresent(email, forKey: "email")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        number = try container.decodeIfPresent(String.self, forKey: "number")
        email = try container.decodeIfPresent(String.self, forKey: "email")
    }
}
