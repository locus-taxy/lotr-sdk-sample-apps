import Foundation

/** Amount of an item */

open class Amount: Codable {

    public var amount: Double?
    /** Currency for the amount. Value should be one of the active codes of official ISO 4217 currency names. Examples are INR, USD, AED, GBP etc */
    public var currency: String?
    /** A symbol for the currency. If missing, will default to currency string. */
    public var symbol: String?

    public init(amount: Double?, currency: String?, symbol: String?) {
        self.amount = amount
        self.currency = currency
        self.symbol = symbol
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(amount, forKey: "amount")
        try container.encodeIfPresent(currency, forKey: "currency")
        try container.encodeIfPresent(symbol, forKey: "symbol")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        amount = try container.decodeIfPresent(Double.self, forKey: "amount")
        currency = try container.decodeIfPresent(String.self, forKey: "currency")
        symbol = try container.decodeIfPresent(String.self, forKey: "symbol")
    }
}
