import Foundation

/** Denotes the type of update */
public enum BulkUpdateType: String, Codable {
    case location = "LOCATION"
    case taskStatus = "TASK_STATUS"
    case visitStatus = "VISIT_STATUS"
    case lineItemTransaction = "LINE_ITEM_TRANSACTION"
    case appSettingsLog = "APP_SETTINGS_LOG"
    case userVisitStatus = "USER_VISIT_STATUS"
    case tourVisitStatus = "TOUR_VISIT_STATUS"
}
