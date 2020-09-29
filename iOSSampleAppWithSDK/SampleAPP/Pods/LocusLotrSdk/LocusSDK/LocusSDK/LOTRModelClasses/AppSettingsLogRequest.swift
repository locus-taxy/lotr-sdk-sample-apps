import Foundation

/** A log of app settings */

open class AppSettingsLogRequest: Codable {

    /** time at which the log was recorded */
    public var createdOn: Date?
    public var appVersion: Int?
    /** the location mode the app is currently in */
    public var locationMode: String?
    /** boolean to indicate whether mobile data is on */
    public var mobileData: Bool?
    /** number of messages in queue */
    public var unsentCount: Int?
    /** string serialized dump of all settings */
    public var settings: String?
    /** time at which user&#39;s location was last available */
    public var locationLastCapturedOn: Date?

    public init(createdOn: Date?, appVersion: Int?, locationMode: String?, mobileData: Bool?, unsentCount: Int?, settings: String?, locationLastCapturedOn: Date?) {
        self.createdOn = createdOn
        self.appVersion = appVersion
        self.locationMode = locationMode
        self.mobileData = mobileData
        self.unsentCount = unsentCount
        self.settings = settings
        self.locationLastCapturedOn = locationLastCapturedOn
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(createdOn, forKey: "createdOn")
        try container.encodeIfPresent(appVersion, forKey: "appVersion")
        try container.encodeIfPresent(locationMode, forKey: "locationMode")
        try container.encodeIfPresent(mobileData, forKey: "mobileData")
        try container.encodeIfPresent(unsentCount, forKey: "unsentCount")
        try container.encodeIfPresent(settings, forKey: "settings")
        try container.encodeIfPresent(locationLastCapturedOn, forKey: "locationLastCapturedOn")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        createdOn = try container.decodeIfPresent(Date.self, forKey: "createdOn")
        appVersion = try container.decodeIfPresent(Int.self, forKey: "appVersion")
        locationMode = try container.decodeIfPresent(String.self, forKey: "locationMode")
        mobileData = try container.decodeIfPresent(Bool.self, forKey: "mobileData")
        unsentCount = try container.decodeIfPresent(Int.self, forKey: "unsentCount")
        settings = try container.decodeIfPresent(String.self, forKey: "settings")
        locationLastCapturedOn = try container.decodeIfPresent(Date.self, forKey: "locationLastCapturedOn")
    }
}
