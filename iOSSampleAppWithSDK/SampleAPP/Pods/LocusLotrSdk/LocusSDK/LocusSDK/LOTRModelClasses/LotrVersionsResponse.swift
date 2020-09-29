import Foundation

/** Response containing list of notifications channels */

open class LotrVersionsResponse: Codable {

    /** A notification channel object which has user id and version */
    public var versions: [String: NotificationChannel]?

    public init(versions: [String: NotificationChannel]?) {
        self.versions = versions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(versions, forKey: "versions")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        versions = try container.decodeIfPresent([String: NotificationChannel].self, forKey: "versions")
    }
}
