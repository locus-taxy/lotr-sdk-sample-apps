import Foundation

open class GenerateOtpRequest: Codable {

    public var phoneNumber: String?

    public init(phoneNumber: String?) {
        self.phoneNumber = phoneNumber
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(phoneNumber, forKey: "phoneNumber")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        phoneNumber = try container.decodeIfPresent(String.self, forKey: "phoneNumber")
    }
}
