import Foundation

/** Info about the device that the app is running on */

open class DeviceInfo: Codable {

    /** Operating system name */
    public var osName: String?
    /** Operating system version */
    public var osVersion: String?
    /** Device Model name or number */
    public var deviceType: String?
    /** A unique identifier for the device, like IMEI */
    public var deviceId: String?
    /** Type of the unique identifier for the device, like IMEI */
    public var deviceIdType: String?
    /** Timestamp when the device registered its device info */
    public var registeredOn: Date?
    /** Any extra available information about the device or OS, formatted as json, and then serialized into string */
    public var extra: String?

    public init(osName: String?, osVersion: String?, deviceType: String?, deviceId: String?, deviceIdType: String?, registeredOn: Date?, extra: String?) {
        self.osName = osName
        self.osVersion = osVersion
        self.deviceType = deviceType
        self.deviceId = deviceId
        self.deviceIdType = deviceIdType
        self.registeredOn = registeredOn
        self.extra = extra
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(osName, forKey: "osName")
        try container.encodeIfPresent(osVersion, forKey: "osVersion")
        try container.encodeIfPresent(deviceType, forKey: "deviceType")
        try container.encodeIfPresent(deviceId, forKey: "deviceId")
        try container.encodeIfPresent(deviceIdType, forKey: "deviceIdType")
        try container.encodeIfPresent(registeredOn, forKey: "registeredOn")
        try container.encodeIfPresent(extra, forKey: "extra")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        osName = try container.decodeIfPresent(String.self, forKey: "osName")
        osVersion = try container.decodeIfPresent(String.self, forKey: "osVersion")
        deviceType = try container.decodeIfPresent(String.self, forKey: "deviceType")
        deviceId = try container.decodeIfPresent(String.self, forKey: "deviceId")
        deviceIdType = try container.decodeIfPresent(String.self, forKey: "deviceIdType")
        registeredOn = try container.decodeIfPresent(Date.self, forKey: "registeredOn")
        extra = try container.decodeIfPresent(String.self, forKey: "extra")
    }
}
