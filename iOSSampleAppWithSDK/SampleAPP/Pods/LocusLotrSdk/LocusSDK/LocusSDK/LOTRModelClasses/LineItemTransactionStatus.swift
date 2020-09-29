import Foundation

/** Transaction status of a line item */

open class LineItemTransactionStatus: Codable {

    /** id of the line item */
    public var id: String?
    public var transactionStatus: TransactionStatus?

    public init(id: String?, transactionStatus: TransactionStatus?) {
        self.id = id
        self.transactionStatus = transactionStatus
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(transactionStatus, forKey: "transactionStatus")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        transactionStatus = try container.decodeIfPresent(TransactionStatus.self, forKey: "transactionStatus")
    }
}
