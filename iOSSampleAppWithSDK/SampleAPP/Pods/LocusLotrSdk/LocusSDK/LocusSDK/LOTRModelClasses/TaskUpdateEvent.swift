import Foundation

/** Event denoting an update to a task */

open class TaskUpdateEvent: Codable {

    /** A snapshot of the task object at the time the event was triggered. Note that this will reflect a snapshot of the object at the time the event was triggered, which may not be the latest state. This difference can become more prominent in case there is a delay in delivery of or receiving the callback. */
    public var task: Task?

    public init(task: Task?) {
        self.task = task
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(task, forKey: "task")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        task = try container.decodeIfPresent(Task.self, forKey: "task")
    }
}
