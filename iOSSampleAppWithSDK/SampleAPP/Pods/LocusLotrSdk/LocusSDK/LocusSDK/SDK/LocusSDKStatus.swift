import Foundation

/// Locus SDK Statuses
///
/// - notInitialized: initial state
/// - authenticated: once the sdk is initialized (i.e authenticated with server)
/// - tracking: sdk is active and tracking location updates
/// - trackingWithoutPermission: if the sdk has started tracking and the user changes permission to Never/WhileUsingTheApp then it goes to this state and will resume the tracking when Always permission is set
public enum LocusSDKStatus: String {

    case notInitialized = "Not Initialized"

    case authenticated = "Authenticated"

    case tracking = "Tracking"

    case trackingWithoutPermission = "Tracking Without Permission"
}
