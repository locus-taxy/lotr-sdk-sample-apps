import Foundation

/** A container for asynchronous communications settings */

open class AsyncCommunicationSetting: Codable {

    /** Integer to indicate the minimum number of updates required to be accumulated in queue before an API call is made */
    public var batchMinCount: Int?
    /** Integer to indicate the number of seconds after which an API call is forcefully allowed, regardless of number of updates in queue */
    public var batchUpdatesTimeout: Int?

    public init(batchMinCount: Int?, batchUpdatesTimeout: Int?) {
        self.batchMinCount = batchMinCount
        self.batchUpdatesTimeout = batchUpdatesTimeout
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(batchMinCount, forKey: "batchMinCount")
        try container.encodeIfPresent(batchUpdatesTimeout, forKey: "batchUpdatesTimeout")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        batchMinCount = try container.decodeIfPresent(Int.self, forKey: "batchMinCount")
        batchUpdatesTimeout = try container.decodeIfPresent(Int.self, forKey: "batchUpdatesTimeout")
    }
}
