import Foundation

/// Locus SDK delegate is required during SDK initialization
public protocol LocusSDKDelegate: class {

    /// This is called when the status of the SDK changes
    ///
    /// - Parameter status: updated status of the SDK
    func locusSDKStatusChanged(status: LocusSDKStatus)

    /// This called when ever there is location update that is significant
    ///
    /// - Parameter location: updated location
    func onLocationUpdated(location: Location)

    /// This is called when there is an error in the SDK
    ///
    /// - Parameter error: LocusSDKError a representation of the error occured

    func onLocationError(error: LocusSDKError)

    /// This called when ever there is location that is uploaded to locus server
    ///
    /// - Parameter location: updated location
    func onLocationUploaded(location: Location)

    /// This is called when the sdk changes from offline/online or vice versa
    /// SDK is online if the lastSentLocation is less than a threshold time (600 sec or ClientAppConfig.locationStaleTime)
    ///
    /// - Parameter isOffline: updated status
    func isOfflineStatusChanged(isOffline: Bool)

    /// This is called when events of importance happen in the SDK that needs to logged by the Application
    ///
    /// - Parameters:
    ///   - tag: Event tag
    ///   - message: Event message
    ///   - logLevel: Event log level

    func logEvent(tag: String, message: String, logLevel: LocusSDKLogLevel)
}

extension LocusSDKDelegate {
    func onLocationUpdated() {
        /* return a default value or just leave empty */
    }

    func onLocationUploaded() {
        /* return a default value or just leave empty */
    }
}
