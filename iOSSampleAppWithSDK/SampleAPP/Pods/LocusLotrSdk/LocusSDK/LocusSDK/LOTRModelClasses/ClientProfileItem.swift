import Foundation

/** Client profile item to be populated on Locus delivery app */

open class ClientProfileItem: Codable {

    public enum Action: String, Codable {
        case intent = "INTENT"
        case url = "URL"
        case _none = "NONE"
        case implicitIntent = "IMPLICIT_INTENT"
    }

    /** Action to take when activated */
    public var action: Action?
    /** Arguments to be used to perform the required action */
    public var arguments: [String]?

    public init(action: Action?, arguments: [String]?) {
        self.action = action
        self.arguments = arguments
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(action, forKey: "action")
        try container.encodeIfPresent(arguments, forKey: "arguments")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        action = try container.decodeIfPresent(Action.self, forKey: "action")
        arguments = try container.decodeIfPresent([String].self, forKey: "arguments")
    }
}
