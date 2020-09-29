import Foundation

/** A wrapper for task status, with location and time information. */

open class TaskStatus: Codable {

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
    /** Time when the task update was received on the server. */
    public var receiveTime: Date?
    /** Location of the delivery person at the time of the update. */
    public var location: MinimalLocation?
    /** Actor who triggered this status update */
    public var actor: Actor?
    public var assignedUser: AssignedUser?

    public init(status: Status?, triggerTime: Date?, checklistValues: [String: String]?, receiveTime: Date?, location: MinimalLocation?, actor: Actor?, assignedUser: AssignedUser?) {
        self.status = status
        self.triggerTime = triggerTime
        self.checklistValues = checklistValues
        self.receiveTime = receiveTime
        self.location = location
        self.actor = actor
        self.assignedUser = assignedUser
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(triggerTime, forKey: "triggerTime")
        try container.encodeIfPresent(checklistValues, forKey: "checklistValues")
        try container.encodeIfPresent(receiveTime, forKey: "receiveTime")
        try container.encodeIfPresent(location, forKey: "location")
        try container.encodeIfPresent(actor, forKey: "actor")
        try container.encodeIfPresent(assignedUser, forKey: "assignedUser")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decodeIfPresent(Status.self, forKey: "status")
        triggerTime = try container.decodeIfPresent(Date.self, forKey: "triggerTime")
        checklistValues = try container.decodeIfPresent([String: String].self, forKey: "checklistValues")
        receiveTime = try container.decodeIfPresent(Date.self, forKey: "receiveTime")
        location = try container.decodeIfPresent(MinimalLocation.self, forKey: "location")
        actor = try container.decodeIfPresent(Actor.self, forKey: "actor")
        assignedUser = try container.decodeIfPresent(AssignedUser.self, forKey: "assignedUser")
    }
}
