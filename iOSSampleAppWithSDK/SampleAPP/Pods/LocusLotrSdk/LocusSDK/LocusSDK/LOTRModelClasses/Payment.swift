import Foundation

/** A payment request, through any of the payment instruments. */

open class Payment: Codable {

    /** Instrument involved */
    public var instrument: PaymentInstrument?
    /** Id for the payment. Applicable for only ECOD, and ONLINE payments. */
    public var paymentId: PaymentId?
    /** Amount that is expected to be charged. Invoice would have been generated for this amount. */
    public var desiredAmount: Amount?
    /** Amount that was actually charged. */
    public var actualAmount: Amount?
    /** Boolean that denotes whether or not amount can be edited after the invoice is generated. This can support partial payments. */
    public var amountEditable: Bool?
    public var status: PaymentStatus?
    /** Timestamp of creation */
    public var createdOn: Date?
    /** Timestamp of last update */
    public var updatedOn: Date?
    /** Additional information that needs to be shared for the payment */
    public var additionalInfo: [String: String]?

    public init(instrument: PaymentInstrument?, paymentId: PaymentId?, desiredAmount: Amount?, actualAmount: Amount?, amountEditable: Bool?, status: PaymentStatus?, createdOn: Date?, updatedOn: Date?, additionalInfo: [String: String]?) {
        self.instrument = instrument
        self.paymentId = paymentId
        self.desiredAmount = desiredAmount
        self.actualAmount = actualAmount
        self.amountEditable = amountEditable
        self.status = status
        self.createdOn = createdOn
        self.updatedOn = updatedOn
        self.additionalInfo = additionalInfo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(instrument, forKey: "instrument")
        try container.encodeIfPresent(paymentId, forKey: "paymentId")
        try container.encodeIfPresent(desiredAmount, forKey: "desiredAmount")
        try container.encodeIfPresent(actualAmount, forKey: "actualAmount")
        try container.encodeIfPresent(amountEditable, forKey: "amountEditable")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(createdOn, forKey: "createdOn")
        try container.encodeIfPresent(updatedOn, forKey: "updatedOn")
        try container.encodeIfPresent(additionalInfo, forKey: "additionalInfo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        instrument = try container.decodeIfPresent(PaymentInstrument.self, forKey: "instrument")
        paymentId = try container.decodeIfPresent(PaymentId.self, forKey: "paymentId")
        desiredAmount = try container.decodeIfPresent(Amount.self, forKey: "desiredAmount")
        actualAmount = try container.decodeIfPresent(Amount.self, forKey: "actualAmount")
        amountEditable = try container.decodeIfPresent(Bool.self, forKey: "amountEditable")
        status = try container.decodeIfPresent(PaymentStatus.self, forKey: "status")
        createdOn = try container.decodeIfPresent(Date.self, forKey: "createdOn")
        updatedOn = try container.decodeIfPresent(Date.self, forKey: "updatedOn")
        additionalInfo = try container.decodeIfPresent([String: String].self, forKey: "additionalInfo")
    }
}
