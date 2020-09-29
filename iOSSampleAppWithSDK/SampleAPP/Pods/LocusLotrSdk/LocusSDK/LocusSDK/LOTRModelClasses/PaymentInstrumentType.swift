import Foundation

/** Denotes the type of payment instrument */
public enum PaymentInstrumentType: String, Codable {
    case cash = "CASH"
    case coupon = "COUPON"
    case ecod = "ECOD"
    case online = "ONLINE"
}
