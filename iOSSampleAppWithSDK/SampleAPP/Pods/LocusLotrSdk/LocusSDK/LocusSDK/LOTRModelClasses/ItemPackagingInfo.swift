import Foundation

/** Packaging information */

open class ItemPackagingInfo: Codable {

    /** indicates if the item is crated */
    public var isCrated: Bool?
    /** number of cartons of the item */
    public var cartons: Int?
    /** number of pieces of the item that is crated or remaining items */
    public var pieces: Int?

    public init(isCrated: Bool?, cartons: Int?, pieces: Int?) {
        self.isCrated = isCrated
        self.cartons = cartons
        self.pieces = pieces
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(isCrated, forKey: "isCrated")
        try container.encodeIfPresent(cartons, forKey: "cartons")
        try container.encodeIfPresent(pieces, forKey: "pieces")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        isCrated = try container.decodeIfPresent(Bool.self, forKey: "isCrated")
        cartons = try container.decodeIfPresent(Int.self, forKey: "cartons")
        pieces = try container.decodeIfPresent(Int.self, forKey: "pieces")
    }
}
