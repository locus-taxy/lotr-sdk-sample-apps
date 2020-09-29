import Foundation

/** A wrapper for task status, with location and time information. */

open class TaskStatusRequest: Codable {

    public enum Status: String, Codable {
        case received = "RECEIVED"
        case waiting = "WAITING"
        case accepted = "ACCEPTED"
        case started = "STARTED"
        case completed = "COMPLETED"
        case cancelled = "CANCELLED"
        case error = "ERROR"
    }

    public var status: Status?
    /** Time when the task update was triggered on the client side */
    public var triggerTime: Date?
    /** A map containing selected values for each checklist item. */
    public var checklistValues: [String: String]?

    public init(status: Status?, triggerTime: Date?, checklistValues: [String: String]?) {
        self.status = status
        self.triggerTime = triggerTime
        self.checklistValues = checklistValues
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(triggerTime, forKey: "triggerTime")
        try container.encodeIfPresent(checklistValues, forKey: "checklistValues")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decodeIfPresent(Status.self, forKey: "status")
        triggerTime = try container.decodeIfPresent(Date.self, forKey: "triggerTime")
        checklistValues = try container.decodeIfPresent([String: String].self, forKey: "checklistValues")
    }
}
