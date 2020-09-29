import Foundation

/** Service that will be used to obtain locations on app */
public enum LocationProvider: String, Codable {
    case google = "GOOGLE"
    case skyhook = "SKYHOOK"
}
