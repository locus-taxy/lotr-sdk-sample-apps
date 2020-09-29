import Foundation

/** Response containing initialization data for sdk */

open class SdkInitializationResponse: Codable {

    public var config: ClientAppConfig?
    public var user: User?

    public init(config: ClientAppConfig?, user: User?) {
        self.config = config
        self.user = user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(config, forKey: "config")
        try container.encodeIfPresent(user, forKey: "user")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        config = try container.decodeIfPresent(ClientAppConfig.self, forKey: "config")
        user = try container.decodeIfPresent(User.self, forKey: "user")
    }
}
