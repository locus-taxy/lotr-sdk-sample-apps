import Foundation

open class OrderTransactionDetail: Codable {

    /** A flag to denote whether order can be transacted partially or not */
    public var canTransactPartial: Bool?
    public var checklist: Checklist?

    public init(canTransactPartial: Bool?, checklist: Checklist?) {
        self.canTransactPartial = canTransactPartial
        self.checklist = checklist
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(canTransactPartial, forKey: "canTransactPartial")
        try container.encodeIfPresent(checklist, forKey: "checklist")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        canTransactPartial = try container.decodeIfPresent(Bool.self, forKey: "canTransactPartial")
        checklist = try container.decodeIfPresent(Checklist.self, forKey: "checklist")
    }
}
