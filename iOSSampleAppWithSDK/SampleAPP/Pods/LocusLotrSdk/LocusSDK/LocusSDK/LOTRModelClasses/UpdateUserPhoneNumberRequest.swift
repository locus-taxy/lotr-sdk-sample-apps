import Foundation

/** A request to update phone number. If enabled, otp is verified */

open class UpdateUserPhoneNumberRequest: Codable {

    public var phoneNumber: String?
    public var otp: String?

    public init(phoneNumber: String?, otp: String?) {
        self.phoneNumber = phoneNumber
        self.otp = otp
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(phoneNumber, forKey: "phoneNumber")
        try container.encodeIfPresent(otp, forKey: "otp")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        phoneNumber = try container.decodeIfPresent(String.self, forKey: "phoneNumber")
        otp = try container.decodeIfPresent(String.self, forKey: "otp")
    }
}
