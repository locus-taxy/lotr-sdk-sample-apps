import Foundation

/** Minimal info of the client */

open class Client: Codable {

    /** Name of the client */
    public var name: String?
    /** Id of the client */
    public var clientId: String?
    public var clientPreferences: ClientPreferences?

    public init(name: String?, clientId: String?, clientPreferences: ClientPreferences?) {
        self.name = name
        self.clientId = clientId
        self.clientPreferences = clientPreferences
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(clientPreferences, forKey: "clientPreferences")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        clientPreferences = try container.decodeIfPresent(ClientPreferences.self, forKey: "clientPreferences")
    }
}
