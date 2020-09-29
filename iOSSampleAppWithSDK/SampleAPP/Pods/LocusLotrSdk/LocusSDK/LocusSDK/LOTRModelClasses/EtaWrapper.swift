import Foundation

/** Various ETAs for a task status */

open class EtaWrapper: Codable {

    /** Initial ETA for this status */
    public var initialEta: Eta?
    /** Current ETA for this status */
    public var currentEta: Eta?

    public init(initialEta: Eta?, currentEta: Eta?) {
        self.initialEta = initialEta
        self.currentEta = currentEta
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(initialEta, forKey: "initialEta")
        try container.encodeIfPresent(currentEta, forKey: "currentEta")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        initialEta = try container.decodeIfPresent(Eta.self, forKey: "initialEta")
        currentEta = try container.decodeIfPresent(Eta.self, forKey: "currentEta")
    }
}
