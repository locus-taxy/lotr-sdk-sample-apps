import Foundation

/** Event denoting an update to a user or their status */

open class UserUpdateEvent: Codable {

    /** A snapshot of the user object at the time the event was triggered. Note that this will reflect a snapshot of the object at the time the event was triggered, which may not be the latest state. This difference can become more prominent in case there is a delay in delivery of or receiving the callback. */
    public var user: User?

    public init(user: User?) {
        self.user = user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(user, forKey: "user")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        user = try container.decodeIfPresent(User.self, forKey: "user")
    }
}
