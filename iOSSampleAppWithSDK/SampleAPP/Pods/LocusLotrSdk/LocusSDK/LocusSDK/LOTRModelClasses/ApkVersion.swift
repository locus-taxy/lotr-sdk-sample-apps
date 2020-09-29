import Foundation

/** apk version information */

open class ApkVersion: Codable {

    /** version code of the LOTR application */
    public var versionCode: Int?
    /** whether the apk is a reverted build with a higher version code for contingency rollback */
    public var isRollback: Bool?
    /** url to the location of application apk */
    public var url: String?

    public init(versionCode: Int?, isRollback: Bool?, url: String?) {
        self.versionCode = versionCode
        self.isRollback = isRollback
        self.url = url
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(versionCode, forKey: "versionCode")
        try container.encodeIfPresent(isRollback, forKey: "isRollback")
        try container.encodeIfPresent(url, forKey: "url")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        versionCode = try container.decodeIfPresent(Int.self, forKey: "versionCode")
        isRollback = try container.decodeIfPresent(Bool.self, forKey: "isRollback")
        url = try container.decodeIfPresent(String.self, forKey: "url")
    }
}
