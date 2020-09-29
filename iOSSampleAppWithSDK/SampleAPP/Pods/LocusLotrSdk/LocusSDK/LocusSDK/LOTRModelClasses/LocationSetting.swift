import Foundation

/** A container for location settings */

open class LocationSetting: Codable {

    /** Boolean to denote that mobile device should collect locations */
    public var collectLocations: Bool?
    /** Time in seconds after which a location should be considered stale */
    public var locationStaleTime: Int?
    /** Show popup warning for inaccurate locations */
    public var warnInaccurateLocation: Bool?
    /** Allow GPS Locations to be mocked */
    public var allowMockLocation: Bool?
    /** Service that will be used to obtain locations on app */
    public var provider: LocationProvider?
    /** Provider flag to overwrite the global default. If its null, provider will be defaulted to global default otherwise this value will be used */
    public var providerOverride: LocationProvider?
    /** API key for using Skyhook Location Services */
    public var skyhookKey: String?
    /** Settings for tiling on skyhook */
    public var skyhookTilingSettings: SkyhookTilingSettings?

    public init(collectLocations: Bool?, locationStaleTime: Int?, warnInaccurateLocation: Bool?, allowMockLocation: Bool?, provider: LocationProvider?, providerOverride: LocationProvider?, skyhookKey: String?, skyhookTilingSettings: SkyhookTilingSettings?) {
        self.collectLocations = collectLocations
        self.locationStaleTime = locationStaleTime
        self.warnInaccurateLocation = warnInaccurateLocation
        self.allowMockLocation = allowMockLocation
        self.provider = provider
        self.providerOverride = providerOverride
        self.skyhookKey = skyhookKey
        self.skyhookTilingSettings = skyhookTilingSettings
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(collectLocations, forKey: "collectLocations")
        try container.encodeIfPresent(locationStaleTime, forKey: "locationStaleTime")
        try container.encodeIfPresent(warnInaccurateLocation, forKey: "warnInaccurateLocation")
        try container.encodeIfPresent(allowMockLocation, forKey: "allowMockLocation")
        try container.encodeIfPresent(provider, forKey: "provider")
        try container.encodeIfPresent(providerOverride, forKey: "providerOverride")
        try container.encodeIfPresent(skyhookKey, forKey: "skyhookKey")
        try container.encodeIfPresent(skyhookTilingSettings, forKey: "skyhookTilingSettings")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        collectLocations = try container.decodeIfPresent(Bool.self, forKey: "collectLocations")
        locationStaleTime = try container.decodeIfPresent(Int.self, forKey: "locationStaleTime")
        warnInaccurateLocation = try container.decodeIfPresent(Bool.self, forKey: "warnInaccurateLocation")
        allowMockLocation = try container.decodeIfPresent(Bool.self, forKey: "allowMockLocation")
        provider = try container.decodeIfPresent(LocationProvider.self, forKey: "provider")
        providerOverride = try container.decodeIfPresent(LocationProvider.self, forKey: "providerOverride")
        skyhookKey = try container.decodeIfPresent(String.self, forKey: "skyhookKey")
        skyhookTilingSettings = try container.decodeIfPresent(SkyhookTilingSettings.self, forKey: "skyhookTilingSettings")
    }
}
