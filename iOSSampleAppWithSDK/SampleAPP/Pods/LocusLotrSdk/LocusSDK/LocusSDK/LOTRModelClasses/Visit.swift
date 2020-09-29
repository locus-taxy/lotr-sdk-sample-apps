import Foundation

/** A location, or a visit or a stop in the delivery person&#39;s tour */

open class Visit: Codable {

    /** An identifier for the visit, unique within a task graph. */
    public var id: String?
    /** All the volume exchanges applicable for current location. */
    public var volumes: Volumes?
    /** All the resource exchanges applicable for current location. */
    public var resources: Resources?
    /** Status for the visit in delivery person&#39;s tour. */
    public var visitStatus: VisitStatus?
    /** Url for the live view of the trip */
    public var trackLink: String?
    /** The location that has been chosen out of the multiple options for location. */
    public var chosenLocation: VisitLocation?
    /** A map, containing ETA values for each visit status. Key is the visit status, and value is the ETAs. */
    public var eta: [String: MinimalEtaWrapper]?
    /** A list of checklists to be shown to the delivery person on the app. Currently, only applies to  COMPLETED and CANCELLED statuses. For COMPLETED status, you can provide a list of BOOLEAN checklist items; each of which will be rendered as a checkbox. For CANCELLED status, you can provide only one SINGLE_CHOICE item, containing multiple cancellation reasons; each of which will be rendered in a radio-button group. */
    public var checklists: [Checklist]?
    /** Amount that needs to be transacted */
    public var amountTransaction: AmountTransaction?
    public var payments: Payments?
    public var visitMetadata: VisitMetadata?
    public var userVisitType: UserVisitType?
    public var breakType: BreakType?
    public var summary: VisitSummary?
    public var orderDetail: OrderDetail?
    public var appFields: AppFields?
    /** Custom name give to locations by the client */
    public var visitName: String?
    /** Visit level configuration settings that overrides app config settings */
    public var visitAppConfig: VisitAppConfig?
    /** Location details such as is the location verified, location name and id. */
    public var locationDetails: LocationDetails?

    public init(id: String?, volumes: Volumes?, resources: Resources?, visitStatus: VisitStatus?, trackLink: String?, chosenLocation: VisitLocation?, eta: [String: MinimalEtaWrapper]?, checklists: [Checklist]?, amountTransaction: AmountTransaction?, payments: Payments?, visitMetadata: VisitMetadata?, userVisitType: UserVisitType?, breakType: BreakType?, summary: VisitSummary?, orderDetail: OrderDetail?, appFields: AppFields?, visitName: String?, visitAppConfig: VisitAppConfig?, locationDetails: LocationDetails?) {
        self.id = id
        self.volumes = volumes
        self.resources = resources
        self.visitStatus = visitStatus
        self.trackLink = trackLink
        self.chosenLocation = chosenLocation
        self.eta = eta
        self.checklists = checklists
        self.amountTransaction = amountTransaction
        self.payments = payments
        self.visitMetadata = visitMetadata
        self.userVisitType = userVisitType
        self.breakType = breakType
        self.summary = summary
        self.orderDetail = orderDetail
        self.appFields = appFields
        self.visitName = visitName
        self.visitAppConfig = visitAppConfig
        self.locationDetails = locationDetails
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(volumes, forKey: "volumes")
        try container.encodeIfPresent(resources, forKey: "resources")
        try container.encodeIfPresent(visitStatus, forKey: "visitStatus")
        try container.encodeIfPresent(trackLink, forKey: "trackLink")
        try container.encodeIfPresent(chosenLocation, forKey: "chosenLocation")
        try container.encodeIfPresent(eta, forKey: "eta")
        try container.encodeIfPresent(checklists, forKey: "checklists")
        try container.encodeIfPresent(amountTransaction, forKey: "amountTransaction")
        try container.encodeIfPresent(payments, forKey: "payments")
        try container.encodeIfPresent(visitMetadata, forKey: "visitMetadata")
        try container.encodeIfPresent(userVisitType, forKey: "userVisitType")
        try container.encodeIfPresent(breakType, forKey: "breakType")
        try container.encodeIfPresent(summary, forKey: "summary")
        try container.encodeIfPresent(orderDetail, forKey: "orderDetail")
        try container.encodeIfPresent(appFields, forKey: "appFields")
        try container.encodeIfPresent(visitName, forKey: "visitName")
        try container.encodeIfPresent(visitAppConfig, forKey: "visitAppConfig")
        try container.encodeIfPresent(locationDetails, forKey: "locationDetails")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(String.self, forKey: "id")
        volumes = try container.decodeIfPresent(Volumes.self, forKey: "volumes")
        resources = try container.decodeIfPresent(Resources.self, forKey: "resources")
        visitStatus = try container.decodeIfPresent(VisitStatus.self, forKey: "visitStatus")
        trackLink = try container.decodeIfPresent(String.self, forKey: "trackLink")
        chosenLocation = try container.decodeIfPresent(VisitLocation.self, forKey: "chosenLocation")
        eta = try container.decodeIfPresent([String: MinimalEtaWrapper].self, forKey: "eta")
        checklists = try container.decodeIfPresent([Checklist].self, forKey: "checklists")
        amountTransaction = try container.decodeIfPresent(AmountTransaction.self, forKey: "amountTransaction")
        payments = try container.decodeIfPresent(Payments.self, forKey: "payments")
        visitMetadata = try container.decodeIfPresent(VisitMetadata.self, forKey: "visitMetadata")
        userVisitType = try container.decodeIfPresent(UserVisitType.self, forKey: "userVisitType")
        breakType = try container.decodeIfPresent(BreakType.self, forKey: "breakType")
        summary = try container.decodeIfPresent(VisitSummary.self, forKey: "summary")
        orderDetail = try container.decodeIfPresent(OrderDetail.self, forKey: "orderDetail")
        appFields = try container.decodeIfPresent(AppFields.self, forKey: "appFields")
        visitName = try container.decodeIfPresent(String.self, forKey: "visitName")
        visitAppConfig = try container.decodeIfPresent(VisitAppConfig.self, forKey: "visitAppConfig")
        locationDetails = try container.decodeIfPresent(LocationDetails.self, forKey: "locationDetails")
    }
}
