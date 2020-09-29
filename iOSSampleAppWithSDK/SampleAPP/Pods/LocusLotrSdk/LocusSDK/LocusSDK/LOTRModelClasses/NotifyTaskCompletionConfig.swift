import Foundation

/** Notify User to complete Visit once marked arrived */

open class NotifyTaskCompletionConfig: Codable {

    /** If true, notifies user to update status after arriving */
    public var enable: Bool?
    /** Time (in seconds) to wait post arrival to notify visit completion */
    public var notifyWaitTime: Int?

    public init(enable: Bool?, notifyWaitTime: Int?) {
        self.enable = enable
        self.notifyWaitTime = notifyWaitTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(enable, forKey: "enable")
        try container.encodeIfPresent(notifyWaitTime, forKey: "notifyWaitTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        enable = try container.decodeIfPresent(Bool.self, forKey: "enable")
        notifyWaitTime = try container.decodeIfPresent(Int.self, forKey: "notifyWaitTime")
    }
}
