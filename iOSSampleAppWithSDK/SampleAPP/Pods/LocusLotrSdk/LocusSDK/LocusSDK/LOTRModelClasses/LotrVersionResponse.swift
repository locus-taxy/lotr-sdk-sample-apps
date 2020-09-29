import Foundation

/** LOTR version check response */

open class LotrVersionResponse: Codable {

    /** returns true if LOTR application has to be updated */
    public var isUpdateRequired: Bool?
    /** LOTR application information will be shared only if update is required */
    public var lotrInformation: LotrInformation?

    public init(isUpdateRequired: Bool?, lotrInformation: LotrInformation?) {
        self.isUpdateRequired = isUpdateRequired
        self.lotrInformation = lotrInformation
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(isUpdateRequired, forKey: "isUpdateRequired")
        try container.encodeIfPresent(lotrInformation, forKey: "lotrInformation")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        isUpdateRequired = try container.decodeIfPresent(Bool.self, forKey: "isUpdateRequired")
        lotrInformation = try container.decodeIfPresent(LotrInformation.self, forKey: "lotrInformation")
    }
}
