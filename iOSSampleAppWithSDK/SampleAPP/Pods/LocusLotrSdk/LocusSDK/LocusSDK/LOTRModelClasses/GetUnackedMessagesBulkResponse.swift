import Foundation

/** Response of getUnackedMessagesBulk API */

open class GetUnackedMessagesBulkResponse: Codable {

    public var ackMessages: [AckMessage]?
    public var tasks: [Task]?
    public var tourResponses: [UserToursResponse]?
    public var user: User?
    public var configUpdateEvent: AppConfigUpdateEvent?
    public var stateDumpEvent: StateDumpEvent?
    public var logoutEvent: LogoutUserEvent?
    public var appUpdateEvent: AppUpdateEvent?

    public init(ackMessages: [AckMessage]?, tasks: [Task]?, tourResponses: [UserToursResponse]?, user: User?, configUpdateEvent: AppConfigUpdateEvent?, stateDumpEvent: StateDumpEvent?, logoutEvent: LogoutUserEvent?, appUpdateEvent: AppUpdateEvent?) {
        self.ackMessages = ackMessages
        self.tasks = tasks
        self.tourResponses = tourResponses
        self.user = user
        self.configUpdateEvent = configUpdateEvent
        self.stateDumpEvent = stateDumpEvent
        self.logoutEvent = logoutEvent
        self.appUpdateEvent = appUpdateEvent
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(ackMessages, forKey: "ackMessages")
        try container.encodeIfPresent(tasks, forKey: "tasks")
        try container.encodeIfPresent(tourResponses, forKey: "tourResponses")
        try container.encodeIfPresent(user, forKey: "user")
        try container.encodeIfPresent(configUpdateEvent, forKey: "configUpdateEvent")
        try container.encodeIfPresent(stateDumpEvent, forKey: "stateDumpEvent")
        try container.encodeIfPresent(logoutEvent, forKey: "logoutEvent")
        try container.encodeIfPresent(appUpdateEvent, forKey: "appUpdateEvent")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        ackMessages = try container.decodeIfPresent([AckMessage].self, forKey: "ackMessages")
        tasks = try container.decodeIfPresent([Task].self, forKey: "tasks")
        tourResponses = try container.decodeIfPresent([UserToursResponse].self, forKey: "tourResponses")
        user = try container.decodeIfPresent(User.self, forKey: "user")
        configUpdateEvent = try container.decodeIfPresent(AppConfigUpdateEvent.self, forKey: "configUpdateEvent")
        stateDumpEvent = try container.decodeIfPresent(StateDumpEvent.self, forKey: "stateDumpEvent")
        logoutEvent = try container.decodeIfPresent(LogoutUserEvent.self, forKey: "logoutEvent")
        appUpdateEvent = try container.decodeIfPresent(AppUpdateEvent.self, forKey: "appUpdateEvent")
    }
}
