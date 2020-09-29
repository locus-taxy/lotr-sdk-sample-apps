import Foundation

/** Update app version request object */

open class UpdateActiveAppVersionRequest: Codable {

    /** version code of the earliest supported LOTR application */
    public var earliestVersion: Int?

    public init(earliestVersion: Int?) {
        self.earliestVersion = earliestVersion
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(earliestVersion, forKey: "earliestVersion")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        earliestVersion = try container.decodeIfPresent(Int.self, forKey: "earliestVersion")
    }
}
