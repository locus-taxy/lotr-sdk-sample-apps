import Foundation

open class AppPermissionsConfig: Codable {

    /** Boolean to denote if LOTR should ask permission to draw over other apps */
    public var shouldDrawOverApps: Bool?

    public init(shouldDrawOverApps: Bool?) {
        self.shouldDrawOverApps = shouldDrawOverApps
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(shouldDrawOverApps, forKey: "shouldDrawOverApps")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        shouldDrawOverApps = try container.decodeIfPresent(Bool.self, forKey: "shouldDrawOverApps")
    }
}
