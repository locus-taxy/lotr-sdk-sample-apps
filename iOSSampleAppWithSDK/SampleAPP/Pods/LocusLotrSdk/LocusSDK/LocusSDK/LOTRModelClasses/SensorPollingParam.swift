import Foundation

/** A container for client specific configuration to be applied to Locus delivery app. */

open class SensorPollingParam: Codable {

    public var holdWakeLock: Bool?
    public var quickGpsPollingInterval: Int?
    public var slowGpsPollingInterval: Int?
    public var gpsMaxWaitTime: Int?
    public var activityDetectionInterval: Int?

    public init(holdWakeLock: Bool?, quickGpsPollingInterval: Int?, slowGpsPollingInterval: Int?, gpsMaxWaitTime: Int?, activityDetectionInterval: Int?) {
        self.holdWakeLock = holdWakeLock
        self.quickGpsPollingInterval = quickGpsPollingInterval
        self.slowGpsPollingInterval = slowGpsPollingInterval
        self.gpsMaxWaitTime = gpsMaxWaitTime
        self.activityDetectionInterval = activityDetectionInterval
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(holdWakeLock, forKey: "holdWakeLock")
        try container.encodeIfPresent(quickGpsPollingInterval, forKey: "quickGpsPollingInterval")
        try container.encodeIfPresent(slowGpsPollingInterval, forKey: "slowGpsPollingInterval")
        try container.encodeIfPresent(gpsMaxWaitTime, forKey: "gpsMaxWaitTime")
        try container.encodeIfPresent(activityDetectionInterval, forKey: "activityDetectionInterval")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        holdWakeLock = try container.decodeIfPresent(Bool.self, forKey: "holdWakeLock")
        quickGpsPollingInterval = try container.decodeIfPresent(Int.self, forKey: "quickGpsPollingInterval")
        slowGpsPollingInterval = try container.decodeIfPresent(Int.self, forKey: "slowGpsPollingInterval")
        gpsMaxWaitTime = try container.decodeIfPresent(Int.self, forKey: "gpsMaxWaitTime")
        activityDetectionInterval = try container.decodeIfPresent(Int.self, forKey: "activityDetectionInterval")
    }
}
