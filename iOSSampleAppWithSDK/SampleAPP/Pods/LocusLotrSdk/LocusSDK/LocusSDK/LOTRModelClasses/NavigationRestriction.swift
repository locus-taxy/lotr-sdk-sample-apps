import Foundation

public enum NavigationRestriction: String, Codable {
    case highways = "AVOID_HIGHWAYS"
    case ferries = "AVOID_FERRIES"
    case tolls = "AVOID_TOLLS"
}
