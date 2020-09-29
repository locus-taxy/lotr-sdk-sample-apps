import Foundation

/** A single item contained in the order */

open class LineItem: Codable {

    /** Name of the item */
    public var name: String?
    /** Quantity of the item */
    public var quantity: Int?
    /** An identifier for the line item */
    public var id: String?
    /** Price of the item */
    public var price: Amount?
    /** A url for an image of the item */
    public var imageUrl: String?
    public var transactionStatus: TransactionStatus?
    public var packageInfo: ItemPackagingInfo?

    public init(name: String?, quantity: Int?, id: String?, price: Amount?, imageUrl: String?, transactionStatus: TransactionStatus?, packageInfo: ItemPackagingInfo?) {
        self.name = name
        self.quantity = quantity
        self.id = id
        self.price = price
        self.imageUrl = imageUrl
        self.transactionStatus = transactionStatus
        self.packageInfo = packageInfo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(quantity, forKey: "quantity")
        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(price, forKey: "price")
        try container.encodeIfPresent(imageUrl, forKey: "imageUrl")
        try container.encodeIfPresent(transactionStatus, forKey: "transactionStatus")
        try container.encodeIfPresent(packageInfo, forKey: "packageInfo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        quantity = try container.decodeIfPresent(Int.self, forKey: "quantity")
        id = try container.decodeIfPresent(String.self, forKey: "id")
        price = try container.decodeIfPresent(Amount.self, forKey: "price")
        imageUrl = try container.decodeIfPresent(String.self, forKey: "imageUrl")
        transactionStatus = try container.decodeIfPresent(TransactionStatus.self, forKey: "transactionStatus")
        packageInfo = try container.decodeIfPresent(ItemPackagingInfo.self, forKey: "packageInfo")
    }
}
