import Foundation

///  Errors of LocusSDK
///

public enum LocusSDKError: Error {

    case _default(error: Error)

    case general(message: String)

    case networkFailure

    case authError(message: String)

    case illegalState(message: String)

    case reInitializeError

    case invalidLocationPermission

    case locationPlistInfoMissing

    case inputMissing(message: String)

    case inputInvalid(message: String)
}

enum LocusSDKErrorInternal: Error {

    case invalidData

    case illegalArgument(message: String)
}

///  Extensions of LocusSDK
///
extension LocusSDKError: Equatable {

    /// An extension to get LocusSDKError type error
    ///
    /// - Parameter error: any error
    /// - Returns: LocusSDKError
    public static func error(_ error: Error) -> LocusSDKError {
        if let locusSDKError = error as? LocusSDKError {
            return locusSDKError
        }
        return LocusSDKError._default(error: error)
    }

    /// Message
    ///
    /// Description of the error
    public var message: String {
        switch self {

            case let ._default(error):
                return error.localizedDescription

            case let .general(message):
                return message

            case .networkFailure:
                return "Network Failure"

            case let .authError(message):
                return message

            case let .illegalState(message):
                return message

            case .reInitializeError:
                return "SDK is not initialized auth params missing"

            case .invalidLocationPermission:
                return "Invalid location permission.SDK only works if always allow permission given"

            case .locationPlistInfoMissing:
                return "The app's Info.plist must contain both “NSLocationAlwaysAndWhenInUseUsageDescription” and “NSLocationWhenInUseUsageDescription” keys with string values explaining to the user how the app uses this data"

            case let .inputMissing(message), let .inputInvalid(message):
                return message
        }
    }

    public static func == (lhs: LocusSDKError, rhs: LocusSDKError) -> Bool {
        return lhs.message == rhs.message
    }
}
