import Foundation

/** A container for skyhook&#39;s tiling settings */

open class SkyhookTilingSettings: Codable {

    /** Length of edge of surrounding area to be tiled for offline use (in meters) */
    public var edgeLength: Int?
    /** Number of regions to tile. Recommended value between (2-10) */
    public var numberOfRegions: Int?
    /** Limit the space consumed by tiling to a percentage of free disk space, (Range 1 - 100) */
    public var percentFreeSpaceLimit: Int?

    public init(edgeLength: Int?, numberOfRegions: Int?, percentFreeSpaceLimit: Int?) {
        self.edgeLength = edgeLength
        self.numberOfRegions = numberOfRegions
        self.percentFreeSpaceLimit = percentFreeSpaceLimit
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(edgeLength, forKey: "edgeLength")
        try container.encodeIfPresent(numberOfRegions, forKey: "numberOfRegions")
        try container.encodeIfPresent(percentFreeSpaceLimit, forKey: "percentFreeSpaceLimit")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        edgeLength = try container.decodeIfPresent(Int.self, forKey: "edgeLength")
        numberOfRegions = try container.decodeIfPresent(Int.self, forKey: "numberOfRegions")
        percentFreeSpaceLimit = try container.decodeIfPresent(Int.self, forKey: "percentFreeSpaceLimit")
    }
}
