import Foundation

open class FileUploadResponse: Codable {

    public enum Status: String, Codable {
        case success = "SUCCESS"
    }

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
