import Foundation

/** Response containing initialization data for app */

open class AppInitializationResponse: Codable {

    public var config: ClientAppConfig?
    public var user: User?
    public var userToursResponse: UserToursResponse?
    public var client: Client?

    public init(config: ClientAppConfig?, user: User?, userToursResponse: UserToursResponse?, client: Client?) {
        self.config = config
        self.user = user
        self.userToursResponse = userToursResponse
        self.client = client
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(config, forKey: "config")
        try container.encodeIfPresent(user, forKey: "user")
        try container.encodeIfPresent(userToursResponse, forKey: "userToursResponse")
        try container.encodeIfPresent(client, forKey: "client")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        config = try container.decodeIfPresent(ClientAppConfig.self, forKey: "config")
        user = try container.decodeIfPresent(User.self, forKey: "user")
        userToursResponse = try container.decodeIfPresent(UserToursResponse.self, forKey: "userToursResponse")
        client = try container.decodeIfPresent(Client.self, forKey: "client")
    }
}
