import Foundation

/** Status of the payment */
public enum PaymentStatus: String, Codable {
    case pending = "PENDING"
    case success = "SUCCESS"
    case failed = "FAILED"
    case cancelled = "CANCELLED"
}
