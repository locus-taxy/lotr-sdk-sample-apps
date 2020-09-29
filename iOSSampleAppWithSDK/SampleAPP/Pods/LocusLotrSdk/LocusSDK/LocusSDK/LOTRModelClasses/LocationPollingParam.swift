import Foundation

/** Set of values guiding how frequently the location should be polled */

open class LocationPollingParam: Codable {

    /** Distance threshold for current location from destination, in meters. This acts as criteria to decide whether this instance of param should be used or not. If distance of the current location from destination is less than this value, then this should be used to tune the polling frequency. */
    public var leftDistance: Int?
    /** Minimum change in location (in meters) from previous value, after which a location should be recorded and communicated to server. */
    public var minChange: Int?
    /** Maximum amount of time (in seconds) that should elapse betwen two location updates, irrespective of whether there was a significant change or not. After this much gap, a location should be recorded and communicated to server. */
    public var maxTimeGap: Int?
    /** Minimum amount of time (in seconds) that should elapse betwen two location updates. Locations shouldn&#39;t be collected more frequently than this. */
    public var minTimeGap: Int?

    public init(leftDistance: Int?, minChange: Int?, maxTimeGap: Int?, minTimeGap: Int?) {
        self.leftDistance = leftDistance
        self.minChange = minChange
        self.maxTimeGap = maxTimeGap
        self.minTimeGap = minTimeGap
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(leftDistance, forKey: "leftDistance")
        try container.encodeIfPresent(minChange, forKey: "minChange")
        try container.encodeIfPresent(maxTimeGap, forKey: "maxTimeGap")
        try container.encodeIfPresent(minTimeGap, forKey: "minTimeGap")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        leftDistance = try container.decodeIfPresent(Int.self, forKey: "leftDistance")
        minChange = try container.decodeIfPresent(Int.self, forKey: "minChange")
        maxTimeGap = try container.decodeIfPresent(Int.self, forKey: "maxTimeGap")
        minTimeGap = try container.decodeIfPresent(Int.self, forKey: "minTimeGap")
    }
}
