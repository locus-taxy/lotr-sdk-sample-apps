import Foundation

/** A delivery or a pickup order */

open class Task: Codable {

    /** Id of the client who added this task */
    public var clientId: String?
    /** Id of the task that client knows */
    public var taskId: String?
    /** Status of the task */
    public var status: TaskStatus?
    /** Order Id for which this task is being generated */
    public var sourceOrderId: String?
    public var orderDetail: OrderDetail?
    /** A user to whom this task is assigned */
    public var assignedUser: AssignedUser?
    /** Time of order creation, in UTC using the standard ISO 8601 format */
    public var creationTime: Date?
    /** Time of task completion, in UTC using the standard ISO 8601 format */
    public var completionTime: Date?
    /** A list of checklists to be shown to the delivery person on the app. Currently, only applies to  COMPLETED and CANCELLED task statuses. For COMPLETED status, you can provide a list of BOOLEAN checklist items; each of which will render as a checkbox. For CANCELLED status, you can provide only one SINGLE_CHOICE item, containing multiple cancellation reasons; each of which will render in a radio-button group. */
    public var checklists: [Checklist]?
    /** List of task status updates, in the order they happen. This can have multiple entries for a status if the status was updated multiple times. */
    public var statusUpdates: [TaskStatus]?
    /** Key value pair for custom properties that clients may want to maintain */
    public var customFields: [String: String]?
    /** Graph representation of the task */
    public var taskGraph: TaskGraph?
    /** List of teams of carrier client to consider for this task assignment */
    public var carrierTeams: [TeamId]?
    /** Task level configuration setting that overrides app config settings */
    public var taskAppConfig: TaskAppConfig?

    public init(clientId: String?, taskId: String?, status: TaskStatus?, sourceOrderId: String?, orderDetail: OrderDetail?, assignedUser: AssignedUser?, creationTime: Date?, completionTime: Date?, checklists: [Checklist]?, statusUpdates: [TaskStatus]?, customFields: [String: String]?, taskGraph: TaskGraph?, carrierTeams: [TeamId]?, taskAppConfig: TaskAppConfig?) {
        self.clientId = clientId
        self.taskId = taskId
        self.status = status
        self.sourceOrderId = sourceOrderId
        self.orderDetail = orderDetail
        self.assignedUser = assignedUser
        self.creationTime = creationTime
        self.completionTime = completionTime
        self.checklists = checklists
        self.statusUpdates = statusUpdates
        self.customFields = customFields
        self.taskGraph = taskGraph
        self.carrierTeams = carrierTeams
        self.taskAppConfig = taskAppConfig
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(taskId, forKey: "taskId")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(sourceOrderId, forKey: "sourceOrderId")
        try container.encodeIfPresent(orderDetail, forKey: "orderDetail")
        try container.encodeIfPresent(assignedUser, forKey: "assignedUser")
        try container.encodeIfPresent(creationTime, forKey: "creationTime")
        try container.encodeIfPresent(completionTime, forKey: "completionTime")
        try container.encodeIfPresent(checklists, forKey: "checklists")
        try container.encodeIfPresent(statusUpdates, forKey: "statusUpdates")
        try container.encodeIfPresent(customFields, forKey: "customFields")
        try container.encodeIfPresent(taskGraph, forKey: "taskGraph")
        try container.encodeIfPresent(carrierTeams, forKey: "carrierTeams")
        try container.encodeIfPresent(taskAppConfig, forKey: "taskAppConfig")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        taskId = try container.decodeIfPresent(String.self, forKey: "taskId")
        status = try container.decodeIfPresent(TaskStatus.self, forKey: "status")
        sourceOrderId = try container.decodeIfPresent(String.self, forKey: "sourceOrderId")
        orderDetail = try container.decodeIfPresent(OrderDetail.self, forKey: "orderDetail")
        assignedUser = try container.decodeIfPresent(AssignedUser.self, forKey: "assignedUser")
        creationTime = try container.decodeIfPresent(Date.self, forKey: "creationTime")
        completionTime = try container.decodeIfPresent(Date.self, forKey: "completionTime")
        checklists = try container.decodeIfPresent([Checklist].self, forKey: "checklists")
        statusUpdates = try container.decodeIfPresent([TaskStatus].self, forKey: "statusUpdates")
        customFields = try container.decodeIfPresent([String: String].self, forKey: "customFields")
        taskGraph = try container.decodeIfPresent(TaskGraph.self, forKey: "taskGraph")
        carrierTeams = try container.decodeIfPresent([TeamId].self, forKey: "carrierTeams")
        taskAppConfig = try container.decodeIfPresent(TaskAppConfig.self, forKey: "taskAppConfig")
    }
}
