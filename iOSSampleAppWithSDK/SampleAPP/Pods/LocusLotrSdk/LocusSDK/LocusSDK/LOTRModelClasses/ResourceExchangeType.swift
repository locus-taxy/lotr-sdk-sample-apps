import Foundation

/** Denotes the type of exchange that needs to happen for the resource, from delivery person&#39;s perspective. */
public enum ResourceExchangeType: String, Codable {
    case give = "GIVE"
    case collect = "COLLECT"
}
