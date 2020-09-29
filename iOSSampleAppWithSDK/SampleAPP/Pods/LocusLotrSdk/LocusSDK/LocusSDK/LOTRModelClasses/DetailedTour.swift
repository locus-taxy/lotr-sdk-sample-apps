import Foundation

open class DetailedTour: Codable {

    public var tourId: TourId?
    public var tourName: String?
    public var plannedTour: Tour?
    /** Date of the tour. e.g. 2017-08-31 */
    public var tourDate: String?
    public var isMultiDay: Bool?
    public var eta: [String: EtaWrapper]?
    public var timeSlot: TimeSlot?
    public var status: DetailedTourStatus?
    public var statusUpdates: [DetailedTourStatus]?

    public init(tourId: TourId?, tourName: String?, plannedTour: Tour?, tourDate: String?, isMultiDay: Bool?, eta: [String: EtaWrapper]?, timeSlot: TimeSlot?, status: DetailedTourStatus?, statusUpdates: [DetailedTourStatus]?) {
        self.tourId = tourId
        self.tourName = tourName
        self.plannedTour = plannedTour
        self.tourDate = tourDate
        self.isMultiDay = isMultiDay
        self.eta = eta
        self.timeSlot = timeSlot
        self.status = status
        self.statusUpdates = statusUpdates
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(tourId, forKey: "tourId")
        try container.encodeIfPresent(tourName, forKey: "tourName")
        try container.encodeIfPresent(plannedTour, forKey: "plannedTour")
        try container.encodeIfPresent(tourDate, forKey: "tourDate")
        try container.encodeIfPresent(isMultiDay, forKey: "isMultiDay")
        try container.encodeIfPresent(eta, forKey: "eta")
        try container.encodeIfPresent(timeSlot, forKey: "timeSlot")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(statusUpdates, forKey: "statusUpdates")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        tourId = try container.decodeIfPresent(TourId.self, forKey: "tourId")
        tourName = try container.decodeIfPresent(String.self, forKey: "tourName")
        plannedTour = try container.decodeIfPresent(Tour.self, forKey: "plannedTour")
        tourDate = try container.decodeIfPresent(String.self, forKey: "tourDate")
        isMultiDay = try container.decodeIfPresent(Bool.self, forKey: "isMultiDay")
        eta = try container.decodeIfPresent([String: EtaWrapper].self, forKey: "eta")
        timeSlot = try container.decodeIfPresent(TimeSlot.self, forKey: "timeSlot")
        status = try container.decodeIfPresent(DetailedTourStatus.self, forKey: "status")
        statusUpdates = try container.decodeIfPresent([DetailedTourStatus].self, forKey: "statusUpdates")
    }
}
