import Foundation

/** A person using one of our apps (can be an end customer using RideSafe app, or a delivery person using the delivery boy app) */

open class User: Codable {

    /** Id of the client who added this user */
    public var clientId: String?
    /** Id of the user that client knows */
    public var userId: String?
    /** Name of the user */
    public var name: String?
    public var email: String?
    /** Phone number of the user. Include country code along with phone number. */
    public var phone: String?
    public var photoUrl: String?
    /** Status of the user */
    public var status: UserStatus?
    /** Flag to denote if user&#39;s phone number is verified */
    public var isPhoneNumberVerified: Bool?
    /** Timestamp of verification of phone number */
    public var phoneNumberVerifiedAt: Date?

    public init(clientId: String?, userId: String?, name: String?, email: String?, phone: String?, photoUrl: String?, status: UserStatus?, isPhoneNumberVerified: Bool?, phoneNumberVerifiedAt: Date?) {
        self.clientId = clientId
        self.userId = userId
        self.name = name
        self.email = email
        self.phone = phone
        self.photoUrl = photoUrl
        self.status = status
        self.isPhoneNumberVerified = isPhoneNumberVerified
        self.phoneNumberVerifiedAt = phoneNumberVerifiedAt
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(userId, forKey: "userId")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(email, forKey: "email")
        try container.encodeIfPresent(phone, forKey: "phone")
        try container.encodeIfPresent(photoUrl, forKey: "photoUrl")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(isPhoneNumberVerified, forKey: "isPhoneNumberVerified")
        try container.encodeIfPresent(phoneNumberVerifiedAt, forKey: "phoneNumberVerifiedAt")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        userId = try container.decodeIfPresent(String.self, forKey: "userId")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        email = try container.decodeIfPresent(String.self, forKey: "email")
        phone = try container.decodeIfPresent(String.self, forKey: "phone")
        photoUrl = try container.decodeIfPresent(String.self, forKey: "photoUrl")
        status = try container.decodeIfPresent(UserStatus.self, forKey: "status")
        isPhoneNumberVerified = try container.decodeIfPresent(Bool.self, forKey: "isPhoneNumberVerified")
        phoneNumberVerifiedAt = try container.decodeIfPresent(Date.self, forKey: "phoneNumberVerifiedAt")
    }
}
