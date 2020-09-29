import Foundation

/** Minimal ETAs for a visit status */

open class MinimalEtaWrapper: Codable {

    /** Current ETA for this status */
    public var currentEta: MinimalEta?

    public init(currentEta: MinimalEta?) {
        self.currentEta = currentEta
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(currentEta, forKey: "currentEta")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        currentEta = try container.decodeIfPresent(MinimalEta.self, forKey: "currentEta")
    }
}
