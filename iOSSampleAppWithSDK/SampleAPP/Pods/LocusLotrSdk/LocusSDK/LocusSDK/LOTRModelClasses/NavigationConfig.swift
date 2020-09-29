import Foundation

/** A container for navigation settings to be applied to Locus delivery app */

open class NavigationConfig: Codable {

    /** List of navigation restrictions */
    public var restrictions: [NavigationRestriction]?
    /** Boolean to denote to use address for navigation */
    public var useAddressToNavigate: Bool?

    public init(restrictions: [NavigationRestriction]?, useAddressToNavigate: Bool?) {
        self.restrictions = restrictions
        self.useAddressToNavigate = useAddressToNavigate
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(restrictions, forKey: "restrictions")
        try container.encodeIfPresent(useAddressToNavigate, forKey: "useAddressToNavigate")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        restrictions = try container.decodeIfPresent([NavigationRestriction].self, forKey: "restrictions")
        useAddressToNavigate = try container.decodeIfPresent(Bool.self, forKey: "useAddressToNavigate")
    }
}
