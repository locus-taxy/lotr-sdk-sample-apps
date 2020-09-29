import Foundation

/** Container for all payment related info */

open class Payments: Codable {

    /** Total amount that has to be paid */
    public var totalAmount: Amount?
    /** Remaining amount that has to be paid */
    public var pendingAmount: Amount?
    /** Payment instruments that can be used */
    public var paymentInstruments: [PaymentInstrument]?
    /** All payments associated with this. Can be in any status - successful, failed, pending etc. */
    public var payments: [Payment]?
    /** Boolean to denote that full payment amount is required before completing the task. */
    public var fullAmountRequired: Bool?

    public init(totalAmount: Amount?, pendingAmount: Amount?, paymentInstruments: [PaymentInstrument]?, payments: [Payment]?, fullAmountRequired: Bool?) {
        self.totalAmount = totalAmount
        self.pendingAmount = pendingAmount
        self.paymentInstruments = paymentInstruments
        self.payments = payments
        self.fullAmountRequired = fullAmountRequired
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(totalAmount, forKey: "totalAmount")
        try container.encodeIfPresent(pendingAmount, forKey: "pendingAmount")
        try container.encodeIfPresent(paymentInstruments, forKey: "paymentInstruments")
        try container.encodeIfPresent(payments, forKey: "payments")
        try container.encodeIfPresent(fullAmountRequired, forKey: "fullAmountRequired")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        totalAmount = try container.decodeIfPresent(Amount.self, forKey: "totalAmount")
        pendingAmount = try container.decodeIfPresent(Amount.self, forKey: "pendingAmount")
        paymentInstruments = try container.decodeIfPresent([PaymentInstrument].self, forKey: "paymentInstruments")
        payments = try container.decodeIfPresent([Payment].self, forKey: "payments")
        fullAmountRequired = try container.decodeIfPresent(Bool.self, forKey: "fullAmountRequired")
    }
}
