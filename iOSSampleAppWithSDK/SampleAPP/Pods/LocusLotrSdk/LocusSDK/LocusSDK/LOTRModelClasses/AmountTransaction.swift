import Foundation

/** Transaction of an amount. */

open class AmountTransaction: Codable {

    public enum ExchangeType: String, Codable {
        case collect = "COLLECT"
        case give = "GIVE"
        case _none = "NONE"
    }

    /** Amount that needs to be transacted */
    public var amount: Amount?
    /** Type of transaction. */
    public var exchangeType: ExchangeType?

    public init(amount: Amount?, exchangeType: ExchangeType?) {
        self.amount = amount
        self.exchangeType = exchangeType
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(amount, forKey: "amount")
        try container.encodeIfPresent(exchangeType, forKey: "exchangeType")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        amount = try container.decodeIfPresent(Amount.self, forKey: "amount")
        exchangeType = try container.decodeIfPresent(ExchangeType.self, forKey: "exchangeType")
    }
}
