import Foundation

/** A simple wrapper for user status */

open class UserStatus: Codable {

    public enum Status: String, Codable {
        case available = "AVAILABLE"
        case busyAuto = "BUSY_AUTO"
        case busyManual = "BUSY_MANUAL"
        case disabled = "DISABLED"
        case busyLoggedOut = "BUSY_LOGGED_OUT"
        case error = "ERROR"
    }

    /** Status of the user */
    public var status: Status?

    public init(status: Status?) {
        self.status = status
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(status, forKey: "status")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decodeIfPresent(Status.self, forKey: "status")
    }
}
