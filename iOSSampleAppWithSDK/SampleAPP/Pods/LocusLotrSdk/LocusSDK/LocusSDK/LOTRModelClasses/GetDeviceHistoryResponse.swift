import Foundation

/** Array of DeviceInfo */

open class GetDeviceHistoryResponse: Codable {

    public var deviceInfo: [DeviceInfo]?

    public init(deviceInfo: [DeviceInfo]?) {
        self.deviceInfo = deviceInfo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(deviceInfo, forKey: "deviceInfo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        deviceInfo = try container.decodeIfPresent([DeviceInfo].self, forKey: "deviceInfo")
    }
}
