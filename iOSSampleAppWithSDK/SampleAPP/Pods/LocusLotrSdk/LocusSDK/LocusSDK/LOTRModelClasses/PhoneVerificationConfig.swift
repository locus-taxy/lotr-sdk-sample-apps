import Foundation

open class PhoneVerificationConfig: Codable {

    /** Boolean to denote if phone number should verified via OTP */
    public var shouldVerifyPhoneNumber: Bool?
    /** Number of days a phone number is valid for. After expiry, must be re-verified. */
    public var phoneNumberValidityPeriod: Int?

    public init(shouldVerifyPhoneNumber: Bool?, phoneNumberValidityPeriod: Int?) {
        self.shouldVerifyPhoneNumber = shouldVerifyPhoneNumber
        self.phoneNumberValidityPeriod = phoneNumberValidityPeriod
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(shouldVerifyPhoneNumber, forKey: "shouldVerifyPhoneNumber")
        try container.encodeIfPresent(phoneNumberValidityPeriod, forKey: "phoneNumberValidityPeriod")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        shouldVerifyPhoneNumber = try container.decodeIfPresent(Bool.self, forKey: "shouldVerifyPhoneNumber")
        phoneNumberValidityPeriod = try container.decodeIfPresent(Int.self, forKey: "phoneNumberValidityPeriod")
    }
}
