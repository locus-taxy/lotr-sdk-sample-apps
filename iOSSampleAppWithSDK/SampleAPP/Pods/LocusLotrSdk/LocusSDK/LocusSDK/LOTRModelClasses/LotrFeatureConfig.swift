import Foundation

open class LotrFeatureConfig: Codable {

    /** flag to denote if trip structure should be enabled on the iOS App */
    public var enableTrips: Bool?
    /** Flag to denote if trips screen should be the default screen on the app */
    public var showTripsByDefault: Bool?

    public init(enableTrips: Bool?, showTripsByDefault: Bool?) {
        self.enableTrips = enableTrips
        self.showTripsByDefault = showTripsByDefault
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(enableTrips, forKey: "enableTrips")
        try container.encodeIfPresent(showTripsByDefault, forKey: "showTripsByDefault")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        enableTrips = try container.decodeIfPresent(Bool.self, forKey: "enableTrips")
        showTripsByDefault = try container.decodeIfPresent(Bool.self, forKey: "showTripsByDefault")
    }
}
