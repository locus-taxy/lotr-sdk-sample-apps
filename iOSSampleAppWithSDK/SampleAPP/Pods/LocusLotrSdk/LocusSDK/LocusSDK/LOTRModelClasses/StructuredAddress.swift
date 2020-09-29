import Foundation

/** A real world address */

open class StructuredAddress: Codable {

    /** An id for the address */
    public var id: String?
    /** Name of the place */
    public var placeName: String?
    /** Name of the locality if available */
    public var localityName: String?
    /** Text representation of the address. */
    public var formattedAddress: String?
    /** Zipcode for the address */
    public var pincode: String?
    /** City of the address */
    public var city: String?
    /** State of the address */
    public var state: String?
    /** Country code to uniquely identify the country */
    public var countryCode: String?

    public init(id: String?, placeName: String?, localityName: String?, formattedAddress: String?, pincode: String?, city: String?, state: String?, countryCode: String?) {
        self.id = id
        self.placeName = placeName
        self.localityName = localityName
        self.formattedAddress = formattedAddress
        self.pincode = pincode
        self.city = city
        self.state = state
        self.countryCode = countryCode
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(placeName, forKey: "placeName")
        try container.encodeIfPresent(localityName, forKey: "localityName")
        try container.encodeIfPresent(formattedAddress, forKey: "formattedAddress")
        try container.encodeIfPresent(pincode, forKey: "pincode")
        try container.encodeIfPresent(city, forKey: "city")
        try container.encodeIfPresent(state, forKey: "state")
        try container.encodeIfPresent(countryCode, forKey: "countryCode")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        placeName = try container.decodeIfPresent(String.self, forKey: "placeName")
        localityName = try container.decodeIfPresent(String.self, forKey: "localityName")
        formattedAddress = try container.decodeIfPresent(String.self, forKey: "formattedAddress")
        pincode = try container.decodeIfPresent(String.self, forKey: "pincode")
        city = try container.decodeIfPresent(String.self, forKey: "city")
        state = try container.decodeIfPresent(String.self, forKey: "state")
        countryCode = try container.decodeIfPresent(String.self, forKey: "countryCode")
    }
}
