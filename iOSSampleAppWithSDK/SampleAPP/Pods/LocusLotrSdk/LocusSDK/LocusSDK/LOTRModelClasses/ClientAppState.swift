import Foundation

/** A container for the state of a client app. */

open class ClientAppState: Codable {

    /** State, serialized as json */
    public var state: String?

    public init(state: String?) {
        self.state = state
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(state, forKey: "state")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        state = try container.decodeIfPresent(String.self, forKey: "state")
    }
}
