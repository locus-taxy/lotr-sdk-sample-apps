import Foundation

/** LOTR application details */

open class LotrInformation: Codable {

    /** version code of the LOTR application */
    public var versionCode: Int?
    /** version name of the LOTR application */
    public var versionName: String?
    /** version code of the earliest supported LOTR application */
    public var earliestVersion: Int?
    /** url to the location of application apk */
    public var url: String?
    /** md5 hash of the application apk file */
    public var md5: String?

    public init(versionCode: Int?, versionName: String?, earliestVersion: Int?, url: String?, md5: String?) {
        self.versionCode = versionCode
        self.versionName = versionName
        self.earliestVersion = earliestVersion
        self.url = url
        self.md5 = md5
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(versionCode, forKey: "versionCode")
        try container.encodeIfPresent(versionName, forKey: "versionName")
        try container.encodeIfPresent(earliestVersion, forKey: "earliestVersion")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(md5, forKey: "md5")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        versionCode = try container.decodeIfPresent(Int.self, forKey: "versionCode")
        versionName = try container.decodeIfPresent(String.self, forKey: "versionName")
        earliestVersion = try container.decodeIfPresent(Int.self, forKey: "earliestVersion")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        md5 = try container.decodeIfPresent(String.self, forKey: "md5")
    }
}
