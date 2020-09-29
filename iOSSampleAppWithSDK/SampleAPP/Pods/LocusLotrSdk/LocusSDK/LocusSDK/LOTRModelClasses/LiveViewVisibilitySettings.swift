import Foundation

open class LiveViewVisibilitySettings: Codable {

    /** Boolean to denote if new live view should be the landing page */
    public var isTabbedLiveViewEnabled: Bool?
    /** Boolean to denote if order tab on new live view is enabled */
    public var isOrderTabEnabled: Bool?
    /** Boolean to denote if rider tab on new live view is enabled */
    public var isRiderTabEnabled: Bool?
    /** Boolean to denote if alerts tab on new live view is enabled */
    public var isAlertsTabEnabled: Bool?

    public init(isTabbedLiveViewEnabled: Bool?, isOrderTabEnabled: Bool?, isRiderTabEnabled: Bool?, isAlertsTabEnabled: Bool?) {
        self.isTabbedLiveViewEnabled = isTabbedLiveViewEnabled
        self.isOrderTabEnabled = isOrderTabEnabled
        self.isRiderTabEnabled = isRiderTabEnabled
        self.isAlertsTabEnabled = isAlertsTabEnabled
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(isTabbedLiveViewEnabled, forKey: "isTabbedLiveViewEnabled")
        try container.encodeIfPresent(isOrderTabEnabled, forKey: "isOrderTabEnabled")
        try container.encodeIfPresent(isRiderTabEnabled, forKey: "isRiderTabEnabled")
        try container.encodeIfPresent(isAlertsTabEnabled, forKey: "isAlertsTabEnabled")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        isTabbedLiveViewEnabled = try container.decodeIfPresent(Bool.self, forKey: "isTabbedLiveViewEnabled")
        isOrderTabEnabled = try container.decodeIfPresent(Bool.self, forKey: "isOrderTabEnabled")
        isRiderTabEnabled = try container.decodeIfPresent(Bool.self, forKey: "isRiderTabEnabled")
        isAlertsTabEnabled = try container.decodeIfPresent(Bool.self, forKey: "isAlertsTabEnabled")
    }
}
