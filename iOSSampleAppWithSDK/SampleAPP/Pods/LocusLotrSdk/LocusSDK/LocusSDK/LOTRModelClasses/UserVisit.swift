import Foundation

/** A user&#39;s visit */

open class UserVisit: Codable {

    public var visit: Visit?
    public var userId: UserId?
    /** boolean denoting whether this visit is skipped */
    public var skip: Bool?

    public init(visit: Visit?, userId: UserId?, skip: Bool?) {
        self.visit = visit
        self.userId = userId
        self.skip = skip
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(visit, forKey: "visit")
        try container.encodeIfPresent(userId, forKey: "userId")
        try container.encodeIfPresent(skip, forKey: "skip")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        visit = try container.decodeIfPresent(Visit.self, forKey: "visit")
        userId = try container.decodeIfPresent(UserId.self, forKey: "userId")
        skip = try container.decodeIfPresent(Bool.self, forKey: "skip")
    }
}
