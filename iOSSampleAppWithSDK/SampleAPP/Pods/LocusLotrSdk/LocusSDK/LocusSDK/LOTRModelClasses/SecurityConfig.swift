import Foundation

open class SecurityConfig: Codable {

    /** Boolean to denote if capturing screenshots is allowed */
    public var allowCaptureScreenshots: Bool?

    public init(allowCaptureScreenshots: Bool?) {
        self.allowCaptureScreenshots = allowCaptureScreenshots
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(allowCaptureScreenshots, forKey: "allowCaptureScreenshots")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        allowCaptureScreenshots = try container.decodeIfPresent(Bool.self, forKey: "allowCaptureScreenshots")
    }
}
