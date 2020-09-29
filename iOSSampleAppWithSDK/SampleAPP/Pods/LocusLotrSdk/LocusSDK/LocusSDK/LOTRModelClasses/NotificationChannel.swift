import Foundation

/** A channel over which user can be notified; like FCM, APNS etc */

open class NotificationChannel: Codable {

    public enum ModelType: String, Codable {
        case gcm = "GCM"
        case fcm = "FCM"
        case apns = "APNS"
        case apnsSandbox = "APNS_SANDBOX"
    }

    /** Various notification channel types supported */
    public var type: ModelType?
    /** Id of the channel */
    public var channelId: String?
    /** Version of the app */
    public var appVersion: String?

    public init(type: ModelType?, channelId: String?, appVersion: String?) {
        self.type = type
        self.channelId = channelId
        self.appVersion = appVersion
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(type, forKey: "type")
        try container.encodeIfPresent(channelId, forKey: "channelId")
        try container.encodeIfPresent(appVersion, forKey: "appVersion")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        type = try container.decodeIfPresent(ModelType.self, forKey: "type")
        channelId = try container.decodeIfPresent(String.self, forKey: "channelId")
        appVersion = try container.decodeIfPresent(String.self, forKey: "appVersion")
    }
}
