import Foundation

/** Enum specifiying current status of tour - queued, started or completed. */
public enum TourStatus: String, Codable {
    case queued = "QUEUED"
    case started = "STARTED"
    case completed = "COMPLETED"
}
