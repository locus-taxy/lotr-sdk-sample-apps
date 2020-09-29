import Foundation

/** Location and time related information for a visit */

open class VisitLocation: Codable {

    /** An optional id for the location. This will be used to identify same locations, which can help in improving the fleet plan optimization. */
    public var id: String?
    /** Properties related to the geometry of the place. */
    public var geometry: Geometry?
    /** Time window within which delivery person should be present at the location. */
    public var timeWindow: TimeWindow?
    /** Address for a visit location */
    public var locationAddress: StructuredAddress?
    /** Contact point at a visit location. */
    public var contact: ContactPoint?
    public var geocodingMetadata: GeocodingMetadata?

    public init(id: String?, geometry: Geometry?, timeWindow: TimeWindow?, locationAddress: StructuredAddress?, contact: ContactPoint?, geocodingMetadata: GeocodingMetadata?) {
        self.id = id
        self.geometry = geometry
        self.timeWindow = timeWindow
        self.locationAddress = locationAddress
        self.contact = contact
        self.geocodingMetadata = geocodingMetadata
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(geometry, forKey: "geometry")
        try container.encodeIfPresent(timeWindow, forKey: "timeWindow")
        try container.encodeIfPresent(locationAddress, forKey: "locationAddress")
        try container.encodeIfPresent(contact, forKey: "contact")
        try container.encodeIfPresent(geocodingMetadata, forKey: "geocodingMetadata")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        geometry = try container.decodeIfPresent(Geometry.self, forKey: "geometry")
        timeWindow = try container.decodeIfPresent(TimeWindow.self, forKey: "timeWindow")
        locationAddress = try container.decodeIfPresent(StructuredAddress.self, forKey: "locationAddress")
        contact = try container.decodeIfPresent(ContactPoint.self, forKey: "contact")
        geocodingMetadata = try container.decodeIfPresent(GeocodingMetadata.self, forKey: "geocodingMetadata")
    }
}
