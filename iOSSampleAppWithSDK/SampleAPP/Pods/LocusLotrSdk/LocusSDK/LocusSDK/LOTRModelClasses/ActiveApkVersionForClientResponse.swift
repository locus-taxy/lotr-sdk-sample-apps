import Foundation

/** active apk versions for a specific client */

open class ActiveApkVersionForClientResponse: Codable {

    /** version code of the LOTR application */
    public var versionCode: Int?
    /** url to the location of the application apk */
    public var url: String?
    /** time at which the log was recorded */
    public var activatedOn: Date?

    public init(versionCode: Int?, url: String?, activatedOn: Date?) {
        self.versionCode = versionCode
        self.url = url
        self.activatedOn = activatedOn
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(versionCode, forKey: "versionCode")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(activatedOn, forKey: "activatedOn")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        versionCode = try container.decodeIfPresent(Int.self, forKey: "versionCode")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        activatedOn = try container.decodeIfPresent(Date.self, forKey: "activatedOn")
    }
}
