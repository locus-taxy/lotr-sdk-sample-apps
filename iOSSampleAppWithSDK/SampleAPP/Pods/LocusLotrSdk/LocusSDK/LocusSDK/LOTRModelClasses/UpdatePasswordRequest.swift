import Foundation

open class UpdatePasswordRequest: Codable {

    /** Existing password of the personnel */
    public var existingPassword: String?
    /** New password of the personnel */
    public var newPassword: String?

    public init(existingPassword: String?, newPassword: String?) {
        self.existingPassword = existingPassword
        self.newPassword = newPassword
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(existingPassword, forKey: "existingPassword")
        try container.encodeIfPresent(newPassword, forKey: "newPassword")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        existingPassword = try container.decodeIfPresent(String.self, forKey: "existingPassword")
        newPassword = try container.decodeIfPresent(String.self, forKey: "newPassword")
    }
}
