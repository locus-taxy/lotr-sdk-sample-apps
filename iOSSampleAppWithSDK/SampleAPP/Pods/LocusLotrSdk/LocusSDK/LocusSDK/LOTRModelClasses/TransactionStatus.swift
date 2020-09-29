import Foundation

open class TransactionStatus: Codable {

    /** Quantity of the item that has been transacted */
    public var transactedQuantity: Int?
    /** A map containing selected values for each checklist item. */
    public var checklistValues: [String: String]?
    /** Time when the transaction status update was triggered on the client side */
    public var triggerTime: Date?
    /** Time when the transaction status update was received on Locus server */
    public var receiveTime: Date?

    public init(transactedQuantity: Int?, checklistValues: [String: String]?, triggerTime: Date?, receiveTime: Date?) {
        self.transactedQuantity = transactedQuantity
        self.checklistValues = checklistValues
        self.triggerTime = triggerTime
        self.receiveTime = receiveTime
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(transactedQuantity, forKey: "transactedQuantity")
        try container.encodeIfPresent(checklistValues, forKey: "checklistValues")
        try container.encodeIfPresent(triggerTime, forKey: "triggerTime")
        try container.encodeIfPresent(receiveTime, forKey: "receiveTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        transactedQuantity = try container.decodeIfPresent(Int.self, forKey: "transactedQuantity")
        checklistValues = try container.decodeIfPresent([String: String].self, forKey: "checklistValues")
        triggerTime = try container.decodeIfPresent(Date.self, forKey: "triggerTime")
        receiveTime = try container.decodeIfPresent(Date.self, forKey: "receiveTime")
    }
}
