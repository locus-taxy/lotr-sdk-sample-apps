import Foundation

/** A sequence of visits, to be carried out by a delivery person. */

open class Tour: Codable {

    /** Sequence of visits in this tour */
    public var visits: [TourVisit]?
    public var summary: TourSummary?
    /** Full user visits data */
    public var userVisitsData: [UserVisit]?

    public init(visits: [TourVisit]?, summary: TourSummary?, userVisitsData: [UserVisit]?) {
        self.visits = visits
        self.summary = summary
        self.userVisitsData = userVisitsData
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(visits, forKey: "visits")
        try container.encodeIfPresent(summary, forKey: "summary")
        try container.encodeIfPresent(userVisitsData, forKey: "userVisitsData")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        visits = try container.decodeIfPresent([TourVisit].self, forKey: "visits")
        summary = try container.decodeIfPresent(TourSummary.self, forKey: "summary")
        userVisitsData = try container.decodeIfPresent([UserVisit].self, forKey: "userVisitsData")
    }
}
