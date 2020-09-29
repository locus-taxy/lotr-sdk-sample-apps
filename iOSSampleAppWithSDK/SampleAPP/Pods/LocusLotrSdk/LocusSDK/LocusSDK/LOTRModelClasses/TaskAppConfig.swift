import Foundation

/** A container for task level configuration settings to be applied to Locus delivery app */

open class TaskAppConfig: Codable {

    /** Boolean to denote task should be auto accepted */
    public var autoAccept: Bool?
    /** Boolean to denote that task should be auto started after accepted */
    public var autoStartOnAccept: Bool?
    /** Boolean to denote that task should not be allowed to be cancelled */
    public var hideCancel: Bool?
    /** Boolean to denote that task should not be allowed to be rejected */
    public var hideReject: Bool?
    /** Boolean to denote that task should not be allowed to be rejected after accepted */
    public var hideRejectAfterAccept: Bool?
    /** Threshold to differentiate if task location is nearby. In meters. */
    public var nearbyTaskDistanceThreshold: Int?

    public init(autoAccept: Bool?, autoStartOnAccept: Bool?, hideCancel: Bool?, hideReject: Bool?, hideRejectAfterAccept: Bool?, nearbyTaskDistanceThreshold: Int?) {
        self.autoAccept = autoAccept
        self.autoStartOnAccept = autoStartOnAccept
        self.hideCancel = hideCancel
        self.hideReject = hideReject
        self.hideRejectAfterAccept = hideRejectAfterAccept
        self.nearbyTaskDistanceThreshold = nearbyTaskDistanceThreshold
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(autoAccept, forKey: "autoAccept")
        try container.encodeIfPresent(autoStartOnAccept, forKey: "autoStartOnAccept")
        try container.encodeIfPresent(hideCancel, forKey: "hideCancel")
        try container.encodeIfPresent(hideReject, forKey: "hideReject")
        try container.encodeIfPresent(hideRejectAfterAccept, forKey: "hideRejectAfterAccept")
        try container.encodeIfPresent(nearbyTaskDistanceThreshold, forKey: "nearbyTaskDistanceThreshold")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        autoAccept = try container.decodeIfPresent(Bool.self, forKey: "autoAccept")
        autoStartOnAccept = try container.decodeIfPresent(Bool.self, forKey: "autoStartOnAccept")
        hideCancel = try container.decodeIfPresent(Bool.self, forKey: "hideCancel")
        hideReject = try container.decodeIfPresent(Bool.self, forKey: "hideReject")
        hideRejectAfterAccept = try container.decodeIfPresent(Bool.self, forKey: "hideRejectAfterAccept")
        nearbyTaskDistanceThreshold = try container.decodeIfPresent(Int.self, forKey: "nearbyTaskDistanceThreshold")
    }
}
