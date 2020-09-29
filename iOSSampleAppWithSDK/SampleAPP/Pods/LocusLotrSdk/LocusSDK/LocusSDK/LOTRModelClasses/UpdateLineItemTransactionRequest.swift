import Foundation

/** Update line item transaction request object */

open class UpdateLineItemTransactionRequest: Codable {

    /** A list containing transaction status for each line item */
    public var lineItemsTransactionStatus: [LineItemTransactionStatus]?

    public init(lineItemsTransactionStatus: [LineItemTransactionStatus]?) {
        self.lineItemsTransactionStatus = lineItemsTransactionStatus
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lineItemsTransactionStatus, forKey: "lineItemsTransactionStatus")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lineItemsTransactionStatus = try container.decodeIfPresent([LineItemTransactionStatus].self, forKey: "lineItemsTransactionStatus")
    }
}
