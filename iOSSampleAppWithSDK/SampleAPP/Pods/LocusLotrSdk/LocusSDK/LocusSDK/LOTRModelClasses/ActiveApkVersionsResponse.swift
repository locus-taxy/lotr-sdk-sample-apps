import Foundation

/** active apk versions for each client */

open class ActiveApkVersionsResponse: Codable {

    /** map of clientId to active apk version */
    public var clientApks: [String: ApkVersion]?

    public init(clientApks: [String: ApkVersion]?) {
        self.clientApks = clientApks
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientApks, forKey: "clientApks")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientApks = try container.decodeIfPresent([String: ApkVersion].self, forKey: "clientApks")
    }
}
