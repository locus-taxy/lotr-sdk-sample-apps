import Foundation

/** A DAG (directed acyclic graph) representation of the task. Each node in the graph is a location of interest, that delivery person needs to visit. */

open class TaskGraph: Codable {

    /** Id of the client to whom the task belongs */
    public var clientId: String?
    /** Id of the task within the client, for which this is the DAG representation */
    public var taskId: String?
    /** List of visits that need to be done. */
    public var visits: [Visit]?

    public init(clientId: String?, taskId: String?, visits: [Visit]?) {
        self.clientId = clientId
        self.taskId = taskId
        self.visits = visits
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(taskId, forKey: "taskId")
        try container.encodeIfPresent(visits, forKey: "visits")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        taskId = try container.decodeIfPresent(String.self, forKey: "taskId")
        visits = try container.decodeIfPresent([Visit].self, forKey: "visits")
    }
}
