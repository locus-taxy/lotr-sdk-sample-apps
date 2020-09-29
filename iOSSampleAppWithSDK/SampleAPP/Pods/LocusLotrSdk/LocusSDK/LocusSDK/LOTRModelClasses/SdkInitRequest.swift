import Foundation

/** A request containing all properties needed from sdk */

open class SdkInitRequest: Codable {

    public var deviceInfo: DeviceInfo?
    /** Boolean denoting that the rider state should not be updated; instead just the expected output is returned. Default value is false. deviceInfo is not required if dryRun is set to true */
    public var dryRun: Bool?

    public init(deviceInfo: DeviceInfo?, dryRun: Bool?) {
        self.deviceInfo = deviceInfo
        self.dryRun = dryRun
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(deviceInfo, forKey: "deviceInfo")
        try container.encodeIfPresent(dryRun, forKey: "dryRun")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        deviceInfo = try container.decodeIfPresent(DeviceInfo.self, forKey: "deviceInfo")
        dryRun = try container.decodeIfPresent(Bool.self, forKey: "dryRun")
    }
}
