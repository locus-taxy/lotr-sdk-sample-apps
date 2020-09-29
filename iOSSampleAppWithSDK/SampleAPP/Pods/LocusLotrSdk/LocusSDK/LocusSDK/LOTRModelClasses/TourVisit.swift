import Foundation

/** A location, or a visit or a stop in the delivery person&#39;s tour */

open class TourVisit: Codable {

    public enum VisitSource: String, Codable {
        case task = "TASK"
        case user = "USER"
    }

    /** An identifier for the visit. If the visit comes from a task, this will be the id of visit within the task graph. */
    public var id: String?
    /** A map, containing ETA values for each visit status. Key is the visit status, and value is the ETAs. */
    public var eta: [String: MinimalEtaWrapper]?
    public var visitSource: VisitSource?
    /** Id for the source of this visit. If visit comes from task, this will be the task id. If it comes from user, then this will be user id. */
    public var sourceId: String?
    /** Id of the client containing the source. */
    public var clientId: String?
    public var visitTravel: VisitTravel?

    public init(id: String?, eta: [String: MinimalEtaWrapper]?, visitSource: VisitSource?, sourceId: String?, clientId: String?, visitTravel: VisitTravel?) {
        self.id = id
        self.eta = eta
        self.visitSource = visitSource
        self.sourceId = sourceId
        self.clientId = clientId
        self.visitTravel = visitTravel
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(eta, forKey: "eta")
        try container.encodeIfPresent(visitSource, forKey: "visitSource")
        try container.encodeIfPresent(sourceId, forKey: "sourceId")
        try container.encodeIfPresent(clientId, forKey: "clientId")
        try container.encodeIfPresent(visitTravel, forKey: "visitTravel")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        eta = try container.decodeIfPresent([String: MinimalEtaWrapper].self, forKey: "eta")
        visitSource = try container.decodeIfPresent(VisitSource.self, forKey: "visitSource")
        sourceId = try container.decodeIfPresent(String.self, forKey: "sourceId")
        clientId = try container.decodeIfPresent(String.self, forKey: "clientId")
        visitTravel = try container.decodeIfPresent(VisitTravel.self, forKey: "visitTravel")
    }
}
