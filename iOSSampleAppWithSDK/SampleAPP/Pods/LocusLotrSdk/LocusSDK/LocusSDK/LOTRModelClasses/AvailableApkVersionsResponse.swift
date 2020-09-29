import Foundation

/** list of available apk versions */

open class AvailableApkVersionsResponse: Codable {

    public var apks: [ApkVersion]?

    public init(apks: [ApkVersion]?) {
        self.apks = apks
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(apks, forKey: "apks")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        apks = try container.decodeIfPresent([ApkVersion].self, forKey: "apks")
    }
}
