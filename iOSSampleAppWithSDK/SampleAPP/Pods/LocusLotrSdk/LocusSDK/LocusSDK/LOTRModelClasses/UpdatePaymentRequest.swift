import Foundation

/** Update payment request object */

open class UpdatePaymentRequest: Codable {

    /** All payments to be updated. */
    public var payments: [Payment]?

    public init(payments: [Payment]?) {
        self.payments = payments
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(payments, forKey: "payments")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        payments = try container.decodeIfPresent([Payment].self, forKey: "payments")
    }
}
