import Foundation

open class MinimalCrateSettings: Codable {

    public var enableCrating: Bool?

    public init(enableCrating: Bool?) {
        self.enableCrating = enableCrating
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(enableCrating, forKey: "enableCrating")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        enableCrating = try container.decodeIfPresent(Bool.self, forKey: "enableCrating")
    }
}
