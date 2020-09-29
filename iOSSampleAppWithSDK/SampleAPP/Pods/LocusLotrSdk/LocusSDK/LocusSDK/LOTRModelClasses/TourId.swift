import Foundation

/** An id for a tour */

open class TourId: Codable {

    public var clientId: String?
    public var tourId: String?

    public init(clientId: String?, tourId: String?) {
        self.clientId = clientId
        self.tourId = tourId
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(tourId, forKey: "tourId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        tourId = try container.decodeIfPresent(String.self, forKey: "tourId")
    }
}
