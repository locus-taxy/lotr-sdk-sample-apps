import Foundation

/** crating info */

open class CratingInfo: Codable {

    /** number of crates */
    public var crates: Int?

    public init(crates: Int?) {
        self.crates = crates
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(crates, forKey: "crates")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        crates = try container.decodeIfPresent(Int.self, forKey: "crates")
    }
}
