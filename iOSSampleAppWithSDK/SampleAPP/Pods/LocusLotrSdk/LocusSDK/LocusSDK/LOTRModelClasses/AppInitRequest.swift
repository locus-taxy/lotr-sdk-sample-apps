import Foundation

/** A request containing all properties needed from app */

open class AppInitRequest: Codable {

    public var deviceInfo: DeviceInfo?
    /** local date for fetching tours */
    public var shiftDate: String?
    /** Boolean denoting that the rider state should not be updated; instead just the expected output is returned. Default value is false. deviceInfo is not required if dryRun is set to true */
    public var dryRun: Bool?

    public init(deviceInfo: DeviceInfo?, shiftDate: String?, dryRun: Bool?) {
        self.deviceInfo = deviceInfo
        self.shiftDate = shiftDate
        self.dryRun = dryRun
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(deviceInfo, forKey: "deviceInfo")
        try container.encodeIfPresent(shiftDate, forKey: "shiftDate")
        try container.encodeIfPresent(dryRun, forKey: "dryRun")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        deviceInfo = try container.decodeIfPresent(DeviceInfo.self, forKey: "deviceInfo")
        shiftDate = try container.decodeIfPresent(String.self, forKey: "shiftDate")
        dryRun = try container.decodeIfPresent(Bool.self, forKey: "dryRun")
    }
}
