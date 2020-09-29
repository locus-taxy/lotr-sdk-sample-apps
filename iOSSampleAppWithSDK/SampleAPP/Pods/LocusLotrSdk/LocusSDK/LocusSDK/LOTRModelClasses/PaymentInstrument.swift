import Foundation

/** A method of payment */

open class PaymentInstrument: Codable {

    public var instrumentType: PaymentInstrumentType?
    /** A human friendly name for the payment instrument */
    public var instrumentName: String?
    /** Might not be applicable for all instrument types. */
    public var providerInstrumentId: ProviderInstrumentId?

    public init(instrumentType: PaymentInstrumentType?, instrumentName: String?, providerInstrumentId: ProviderInstrumentId?) {
        self.instrumentType = instrumentType
        self.instrumentName = instrumentName
        self.providerInstrumentId = providerInstrumentId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(instrumentType, forKey: "instrumentType")
        try container.encodeIfPresent(instrumentName, forKey: "instrumentName")
        try container.encodeIfPresent(providerInstrumentId, forKey: "providerInstrumentId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        instrumentType = try container.decodeIfPresent(PaymentInstrumentType.self, forKey: "instrumentType")
        instrumentName = try container.decodeIfPresent(String.self, forKey: "instrumentName")
        providerInstrumentId = try container.decodeIfPresent(ProviderInstrumentId.self, forKey: "providerInstrumentId")
    }
}
