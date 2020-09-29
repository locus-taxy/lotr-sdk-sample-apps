import Foundation

/** Current battery status */

open class BatteryStatus: Codable {

    public enum ChargingStatus: String, Codable {
        case pluggedUsb = "PLUGGED_USB"
        case pluggedAc = "PLUGGED_AC"
        case charging = "CHARGING"
        case _none = "NONE"
        case unavailable = "UNAVAILABLE"
    }

    /** Percentage charge remaining. -1 if status unavailable */
    public var charge: Int?
    /** Expected duration (in mins) for remaining battery life. -1 if status unavailable */
    public var expectedLife: Int?
    public var chargingStatus: ChargingStatus?
    /** Timestamp of the battery status, in millis from epoch */
    public var timestamp: Int64?

    public init(charge: Int?, expectedLife: Int?, chargingStatus: ChargingStatus?, timestamp: Int64?) {
        self.charge = charge
        self.expectedLife = expectedLife
        self.chargingStatus = chargingStatus
        self.timestamp = timestamp
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(charge, forKey: "charge")
        try container.encodeIfPresent(expectedLife, forKey: "expectedLife")
        try container.encodeIfPresent(chargingStatus, forKey: "chargingStatus")
        try container.encodeIfPresent(timestamp, forKey: "timestamp")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        charge = try container.decodeIfPresent(Int.self, forKey: "charge")
        expectedLife = try container.decodeIfPresent(Int.self, forKey: "expectedLife")
        chargingStatus = try container.decodeIfPresent(ChargingStatus.self, forKey: "chargingStatus")
        timestamp = try container.decodeIfPresent(Int64.self, forKey: "timestamp")
    }
}
