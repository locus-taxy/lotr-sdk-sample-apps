import Foundation

/** A team identifier */

open class TeamId: Codable {

    /** Id of the client who manages the given team */
    public var clientId: String?
    /** Id of the team */
    public var teamId: String?

    public init(clientId: String?, teamId: String?) {
        self.clientId = clientId
        self.teamId = teamId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(teamId, forKey: "teamId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        teamId = try container.decodeIfPresent(String.self, forKey: "teamId")
    }
}
