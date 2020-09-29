import Foundation

/** Id of the payment instrument as identified by a provider */

open class PaymentId: Codable {

    public var instrumentId: ProviderInstrumentId?
    /** Id for the payment as identified by the provider. */
    public var paymentId: String?

    public init(instrumentId: ProviderInstrumentId?, paymentId: String?) {
        self.instrumentId = instrumentId
        self.paymentId = paymentId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(instrumentId, forKey: "instrumentId")
        try container.encodeIfPresent(paymentId, forKey: "paymentId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        instrumentId = try container.decodeIfPresent(ProviderInstrumentId.self, forKey: "instrumentId")
        paymentId = try container.decodeIfPresent(String.self, forKey: "paymentId")
    }
}
