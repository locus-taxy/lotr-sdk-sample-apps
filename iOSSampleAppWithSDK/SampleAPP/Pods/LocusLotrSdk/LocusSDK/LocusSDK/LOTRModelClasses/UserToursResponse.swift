import Foundation

/** A user&#39;s tours response */

open class UserToursResponse: Codable {

    public var clientId: String?
    public var userId: String?
    public var tours: [DetailedTour]?
    public var tasks: [Task]?

    public init(clientId: String?, userId: String?, tours: [DetailedTour]?, tasks: [Task]?) {
        self.clientId = clientId
        self.userId = userId
        self.tours = tours
        self.tasks = tasks
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(userId, forKey: "userId")
        try container.encodeIfPresent(tours, forKey: "tours")
        try container.encodeIfPresent(tasks, forKey: "tasks")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        userId = try container.decodeIfPresent(String.self, forKey: "userId")
        tours = try container.decodeIfPresent([DetailedTour].self, forKey: "tours")
        tasks = try container.decodeIfPresent([Task].self, forKey: "tasks")
    }
}
