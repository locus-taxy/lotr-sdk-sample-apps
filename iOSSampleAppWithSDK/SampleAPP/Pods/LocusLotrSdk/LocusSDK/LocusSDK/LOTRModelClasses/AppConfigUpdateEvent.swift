import Foundation

/** An event to trigger update of config for a client app. Corresponds to CONFIG_UPDATE control event type */

open class AppConfigUpdateEvent: Codable {

    public var config: ClientAppConfig?

    public init(config: ClientAppConfig?) {
        self.config = config
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(config, forKey: "config")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        config = try container.decodeIfPresent(ClientAppConfig.self, forKey: "config")
    }
}
