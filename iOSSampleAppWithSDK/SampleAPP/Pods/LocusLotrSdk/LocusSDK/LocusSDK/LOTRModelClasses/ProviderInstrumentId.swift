import Foundation

/** Id of the payment instrument as identified by a provider */

open class ProviderInstrumentId: Codable {

    /** Id of payment instrument provider. For eg, razor-pay for RazorPay instruments. This should be one of the supported values. */
    public var providerId: String?
    /** Id of the payment instrument as identified by the provider. */
    public var instrumentId: String?

    public init(providerId: String?, instrumentId: String?) {
        self.providerId = providerId
        self.instrumentId = instrumentId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(providerId, forKey: "providerId")
        try container.encodeIfPresent(instrumentId, forKey: "instrumentId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        providerId = try container.decodeIfPresent(String.self, forKey: "providerId")
        instrumentId = try container.decodeIfPresent(String.self, forKey: "instrumentId")
    }
}
