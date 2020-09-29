import Foundation

/** Details about the order, line items, amount etc */

open class OrderDetail: Codable {

    public var lineItems: [LineItem]?
    public var transactionDetail: OrderTransactionDetail?
    public var cratingInfo: CratingInfo?

    public init(lineItems: [LineItem]?, transactionDetail: OrderTransactionDetail?, cratingInfo: CratingInfo?) {
        self.lineItems = lineItems
        self.transactionDetail = transactionDetail
        self.cratingInfo = cratingInfo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(lineItems, forKey: "lineItems")
        try container.encodeIfPresent(transactionDetail, forKey: "transactionDetail")
        try container.encodeIfPresent(cratingInfo, forKey: "cratingInfo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        lineItems = try container.decodeIfPresent([LineItem].self, forKey: "lineItems")
        transactionDetail = try container.decodeIfPresent(OrderTransactionDetail.self, forKey: "transactionDetail")
        cratingInfo = try container.decodeIfPresent(CratingInfo.self, forKey: "cratingInfo")
    }
}
