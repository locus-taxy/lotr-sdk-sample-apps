import AVFoundation
import Foundation
import UIKit

class CameraPermission {

    class func checkCameraPermission(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                onSuccess()
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async {
                            onSuccess()
                        }
                        return
                    }
                    LocusSDKImplementation.shared.logEvent(tag: LocusSDKLoggingTags.sdkCamera, message: "Permission Denied", logLevel: .warning)
                    DispatchQueue.main.async {
                        onFailure()
                    }
                }
            case .denied: // The user has previously denied access.
                showCameraPermissionAlert()
                return
            case .restricted: // The user can't grant access due to restrictions.
                LocusSDKImplementation.shared.logEvent(tag: LocusSDKLoggingTags.sdkCamera, message: "Permission restricted", logLevel: .warning)
                return
            @unknown default:
                return
        }
    }

    class func showCameraPermissionAlert() {
        Messages.showAlert(title: L10n.Permissions.Camera.Alert.title, message: L10n.Permissions.Camera.Alert.message, dismissButtonTitle: L10n.Permissions.Camera.Alert.dismiss, confirmButtonTitle: L10n.Permissions.Camera.Alert.settings, dismissActionBlock: {}) {
            openCameraSetting()
        }
    }

    class func openCameraSetting() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
