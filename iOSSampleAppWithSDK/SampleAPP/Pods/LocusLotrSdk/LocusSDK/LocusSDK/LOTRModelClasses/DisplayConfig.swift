import Foundation

/** A container with various settings required for display */

open class DisplayConfig: Codable {

    /** This determines which is primary value that gets displayed in the app for the task */
    public var primaryIdentifier: DisplayIdentifier?
    /** This determines which is secondary value that gets displayed in the app for the task */
    public var secondaryIdentifier: DisplayIdentifier?
    /** Days before current day to display tasks of tours */
    public var tourDaysPastLimit: Int?
    /** Days after current day to display tasks of tours */
    public var tourDaysFutureLimit: Int?
    /** Items to be displayed on small card */
    public var primaryCardConfig: CardConfig?
    /** Items to be displayed on big card */
    public var secondaryCardConfig: CardConfig?
    public var showCratingInfo: Bool?
    public var showOrderHistory: Bool?
    public var showContactUs: Bool?
    /** Url for displaying season&#39;s greetings */
    public var greetingsUrl: String?

    public init(primaryIdentifier: DisplayIdentifier?, secondaryIdentifier: DisplayIdentifier?, tourDaysPastLimit: Int?, tourDaysFutureLimit: Int?, primaryCardConfig: CardConfig?, secondaryCardConfig: CardConfig?, showCratingInfo: Bool?, showOrderHistory: Bool?, showContactUs: Bool?, greetingsUrl: String?) {
        self.primaryIdentifier = primaryIdentifier
        self.secondaryIdentifier = secondaryIdentifier
        self.tourDaysPastLimit = tourDaysPastLimit
        self.tourDaysFutureLimit = tourDaysFutureLimit
        self.primaryCardConfig = primaryCardConfig
        self.secondaryCardConfig = secondaryCardConfig
        self.showCratingInfo = showCratingInfo
        self.showOrderHistory = showOrderHistory
        self.showContactUs = showContactUs
        self.greetingsUrl = greetingsUrl
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(primaryIdentifier, forKey: "primaryIdentifier")
        try container.encodeIfPresent(secondaryIdentifier, forKey: "secondaryIdentifier")
        try container.encodeIfPresent(tourDaysPastLimit, forKey: "tourDaysPastLimit")
        try container.encodeIfPresent(tourDaysFutureLimit, forKey: "tourDaysFutureLimit")
        try container.encodeIfPresent(primaryCardConfig, forKey: "primaryCardConfig")
        try container.encodeIfPresent(secondaryCardConfig, forKey: "secondaryCardConfig")
        try container.encodeIfPresent(showCratingInfo, forKey: "showCratingInfo")
        try container.encodeIfPresent(showOrderHistory, forKey: "showOrderHistory")
        try container.encodeIfPresent(showContactUs, forKey: "showContactUs")
        try container.encodeIfPresent(greetingsUrl, forKey: "greetingsUrl")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        primaryIdentifier = try container.decodeIfPresent(DisplayIdentifier.self, forKey: "primaryIdentifier")
        secondaryIdentifier = try container.decodeIfPresent(DisplayIdentifier.self, forKey: "secondaryIdentifier")
        tourDaysPastLimit = try container.decodeIfPresent(Int.self, forKey: "tourDaysPastLimit")
        tourDaysFutureLimit = try container.decodeIfPresent(Int.self, forKey: "tourDaysFutureLimit")
        primaryCardConfig = try container.decodeIfPresent(CardConfig.self, forKey: "primaryCardConfig")
        secondaryCardConfig = try container.decodeIfPresent(CardConfig.self, forKey: "secondaryCardConfig")
        showCratingInfo = try container.decodeIfPresent(Bool.self, forKey: "showCratingInfo")
        showOrderHistory = try container.decodeIfPresent(Bool.self, forKey: "showOrderHistory")
        showContactUs = try container.decodeIfPresent(Bool.self, forKey: "showContactUs")
        greetingsUrl = try container.decodeIfPresent(String.self, forKey: "greetingsUrl")
    }
}
