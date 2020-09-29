import Foundation

/** Settings for a business client of Locus */

open class ClientPreferences: Codable {

    public var liveViewSettings: LiveViewSettings?

    public init(liveViewSettings: LiveViewSettings?) {
        self.liveViewSettings = liveViewSettings
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(liveViewSettings, forKey: "liveViewSettings")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        liveViewSettings = try container.decodeIfPresent(LiveViewSettings.self, forKey: "liveViewSettings")
    }
}
