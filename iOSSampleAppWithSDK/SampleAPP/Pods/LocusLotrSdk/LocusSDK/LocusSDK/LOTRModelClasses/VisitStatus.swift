import Foundation

/** Status for a visit in delivery person&#39;s tour. This denotes whether delivery person has already reached the location, or is on the way, or has left from the location, etc. */

open class VisitStatus: Codable {

    public enum Status: String, Codable {
        case received = "RECEIVED"
        case waiting = "WAITING"
        case accepted = "ACCEPTED"
        case started = "STARTED"
        case arrived = "ARRIVED"
        case transacting = "TRANSACTING"
        case completed = "COMPLETED"
        case cancelled = "CANCELLED"
    }

    /** Actual status. ACCEPTED - delivery person has accepted the task. STARTED - delivery person is moving towards the location. ARRIVED - delivery person has reached the location, and just waiting there. TRANSACTING - delivery person is at the location, and the transaction is in progress. COMPLETED - delivery person has completed the transaction at the location. */
    public var status: Status?
    /** Time when the status update was triggered on the client side */
    public var triggerTime: Date?
    /** A map containing selected values for each checklist item. */
    public var checklistValues: [String: String]?
    /** Time when the status update was received on Locus server */
    public var receiveTime: Date?
    /** Location of the actor that triggered the update, at the time of the update */
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
