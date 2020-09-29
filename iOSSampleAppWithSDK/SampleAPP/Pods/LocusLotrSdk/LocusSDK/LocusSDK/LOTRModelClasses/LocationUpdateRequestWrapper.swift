import Foundation

open class LocationUpdateRequestWrapper: Codable {

    public var location: Location?
    public var batteryStatus: BatteryStatus?

    public init(location: Location?, batteryStatus: BatteryStatus?) {
        self.location = location
        self.batteryStatus = batteryStatus
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(location, forKey: "location")
        try container.encodeIfPresent(batteryStatus, forKey: "batteryStatus")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        location = try container.decodeIfPresent(Location.self, forKey: "location")
        batteryStatus = try container.decodeIfPresent(BatteryStatus.self, forKey: "batteryStatus")
    }
}
