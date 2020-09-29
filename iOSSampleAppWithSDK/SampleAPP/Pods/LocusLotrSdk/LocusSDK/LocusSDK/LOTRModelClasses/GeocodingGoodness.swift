import Foundation

/** A combined measure of confidence and accuracy */
public enum GeocodingGoodness: String, Codable {
    case high = "HIGH"
    case low = "LOW"
}
