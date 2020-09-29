import Foundation

/** A container for visit level configuration settings to be applied to Locus delivery app */

open class VisitAppConfig: Codable {

    /** List of statuses for which actions should be skipped from the app. */
    public var skipStatuses: [String]?
    /** Boolean to denote that rescheduling visits is allowed */
    public var allowVisitReschedule: Bool?
    /** prevent visit from being completed */
    public var blockCompletion: Bool?
    /** Boolean to denote that completion of visit should be allowed even if 0 items are picked/delivered. If false visit will be cancelled instead. */
    public var allowZeroItemVisitCompletion: Bool?
    /** Boolean to denote that during transaction of a visit, no actions on other visits are allowed */
    public var enforceSingleTransaction: Bool?

    public init(skipStatuses: [String]?, allowVisitReschedule: Bool?, blockCompletion: Bool?, allowZeroItemVisitCompletion: Bool?, enforceSingleTransaction: Bool?) {
        self.skipStatuses = skipStatuses
        self.allowVisitReschedule = allowVisitReschedule
        self.blockCompletion = blockCompletion
        self.allowZeroItemVisitCompletion = allowZeroItemVisitCompletion
        self.enforceSingleTransaction = enforceSingleTransaction
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(skipStatuses, forKey: "skipStatuses")
        try container.encodeIfPresent(allowVisitReschedule, forKey: "allowVisitReschedule")
        try container.encodeIfPresent(blockCompletion, forKey: "blockCompletion")
        try container.encodeIfPresent(allowZeroItemVisitCompletion, forKey: "allowZeroItemVisitCompletion")
        try container.encodeIfPresent(enforceSingleTransaction, forKey: "enforceSingleTransaction")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        skipStatuses = try container.decodeIfPresent([String].self, forKey: "skipStatuses")
        allowVisitReschedule = try container.decodeIfPresent(Bool.self, forKey: "allowVisitReschedule")
        blockCompletion = try container.decodeIfPresent(Bool.self, forKey: "blockCompletion")
        allowZeroItemVisitCompletion = try container.decodeIfPresent(Bool.self, forKey: "allowZeroItemVisitCompletion")
        enforceSingleTransaction = try container.decodeIfPresent(Bool.self, forKey: "enforceSingleTransaction")
    }
}
