import Foundation

/** A container for card settings to be applied to Locus delivery app */

open class CardConfig: Codable {

    public var placeholder1: CardPlaceholder?
    public var placeholder2: CardPlaceholder?

    public init(placeholder1: CardPlaceholder?, placeholder2: CardPlaceholder?) {
        self.placeholder1 = placeholder1
        self.placeholder2 = placeholder2
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(placeholder1, forKey: "placeholder1")
        try container.encodeIfPresent(placeholder2, forKey: "placeholder2")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        placeholder1 = try container.decodeIfPresent(CardPlaceholder.self, forKey: "placeholder1")
        placeholder2 = try container.decodeIfPresent(CardPlaceholder.self, forKey: "placeholder2")
    }
}
