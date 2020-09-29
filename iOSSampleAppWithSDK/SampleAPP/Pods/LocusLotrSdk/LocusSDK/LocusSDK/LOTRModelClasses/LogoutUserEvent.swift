import Foundation

/** An event to trigger logout of the user from the app. Corresponds to LOGOUT_USER control event. */

open class LogoutUserEvent: Codable {

    public var forceLogout: Bool?

    public init(forceLogout: Bool?) {
        self.forceLogout = forceLogout
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(forceLogout, forKey: "forceLogout")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        forceLogout = try container.decodeIfPresent(Bool.self, forKey: "forceLogout")
    }
}
