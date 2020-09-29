import Foundation

/** A time window. */

open class TimeWindow: Codable {

    public enum Strictness: String, Codable {
        case strict = "STRICT"
        case normal = "NORMAL"
        case _optional = "OPTIONAL"
    }

    /** Time slot */
    public var slot: TimeSlot?
    /** Defines how strictly the time slot needs to be adhered to. STRICT - adhere strictly to the slot. NORMAL - adhere to time slot if possible. OPTIONAL - adhering to time slot is desirable, but not mandatory. */
    public var strictness: Strictness?
    /** Boolean that tells whether transaction can happen before the time slot or not. Default is false. */
    public var canTransactBeforeSlot: Bool?
    /** Boolean that tells whether transaction can happen after the time slot or not. Default is false. */
    public var canTransactAfterSlot: Bool?
    /** Boolean that tells whether calculated eta value should be treated as SLA. Default is false. */
    public var treatEtaAsSla: Bool?
    /** Duration required for transaction at the location, in seconds. */
    public var transactionDuration: Int?
    /** Time required for readiness for visit, in seconds. */
    public var readinessDuration: Int?

    public init(slot: TimeSlot?, strictness: Strictness?, canTransactBeforeSlot: Bool?, canTransactAfterSlot: Bool?, treatEtaAsSla: Bool?, transactionDuration: Int?, readinessDuration: Int?) {
        self.slot = slot
        self.strictness = strictness
        self.canTransactBeforeSlot = canTransactBeforeSlot
        self.canTransactAfterSlot = canTransactAfterSlot
        self.treatEtaAsSla = treatEtaAsSla
        self.transactionDuration = transactionDuration
        self.readinessDuration = readinessDuration
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(slot, forKey: "slot")
        try container.encodeIfPresent(strictness, forKey: "strictness")
        try container.encodeIfPresent(canTransactBeforeSlot, forKey: "canTransactBeforeSlot")
        try container.encodeIfPresent(canTransactAfterSlot, forKey: "canTransactAfterSlot")
        try container.encodeIfPresent(treatEtaAsSla, forKey: "treatEtaAsSla")
        try container.encodeIfPresent(transactionDuration, forKey: "transactionDuration")
        try container.encodeIfPresent(readinessDuration, forKey: "readinessDuration")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        slot = try container.decodeIfPresent(TimeSlot.self, forKey: "slot")
        strictness = try container.decodeIfPresent(Strictness.self, forKey: "strictness")
        canTransactBeforeSlot = try container.decodeIfPresent(Bool.self, forKey: "canTransactBeforeSlot")
        canTransactAfterSlot = try container.decodeIfPresent(Bool.self, forKey: "canTransactAfterSlot")
        treatEtaAsSla = try container.decodeIfPresent(Bool.self, forKey: "treatEtaAsSla")
        transactionDuration = try container.decodeIfPresent(Int.self, forKey: "transactionDuration")
        readinessDuration = try container.decodeIfPresent(Int.self, forKey: "readinessDuration")
    }
}
