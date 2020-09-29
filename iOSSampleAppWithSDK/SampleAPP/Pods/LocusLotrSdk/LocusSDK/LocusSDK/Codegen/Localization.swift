// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

    internal enum Checklist {
        internal enum Error {
            /// %@ not selected
            internal static func boolean(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.boolean", String(describing: p1))
            }

            /// %@ not selected
            internal static func date(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.date", String(describing: p1))
            }

            /// %@ must be taken
            internal static func photo(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.photo", String(describing: p1))
            }

            /// %@ Pin must be entered
            internal static func pinAbsent(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.pinAbsent", String(describing: p1))
            }

            /// %@ Pin Invalid!
            internal static func pinInvalid(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.pinInvalid", String(describing: p1))
            }

            /// %@ rating cannot be Zero
            internal static func ratingAbsent(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.ratingAbsent", String(describing: p1))
            }

            /// %@ rating cannot be Zero
            internal static func ratingZero(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.ratingZero", String(describing: p1))
            }

            /// An option of %@ must be selected
            internal static func singleChoice(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.singleChoice", String(describing: p1))
            }

            /// %@ cannot be empty
            internal static func textfield(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.textfield", String(describing: p1))
            }

            /// %@ not selected
            internal static func time(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.time", String(describing: p1))
            }

            /// %@ must be visited
            internal static func url(_ p1: Any) -> String {
                return L10n.tr("Localizable", "checklist.error.url", String(describing: p1))
            }
        }

        internal enum View {
            /// Enter details to complete
            internal static let subtitle = L10n.tr("Localizable", "checklist.view.subtitle")
            /// Checklist
            internal static let title = L10n.tr("Localizable", "checklist.view.title")
            /// URL
            internal static let url = L10n.tr("Localizable", "checklist.view.url")
            internal enum Datetime {
                /// Date
                internal static let date = L10n.tr("Localizable", "checklist.view.datetime.date")
                /// Select date
                internal static let selectDate = L10n.tr("Localizable", "checklist.view.datetime.selectDate")
                /// Select time
                internal static let selectTime = L10n.tr("Localizable", "checklist.view.datetime.selectTime")
                /// Time
                internal static let time = L10n.tr("Localizable", "checklist.view.datetime.time")
            }

            internal enum Photo {
                /// Retake
                internal static let retake = L10n.tr("Localizable", "checklist.view.photo.retake")
            }

            internal enum Signature {
                /// Sign your name using your finger
                internal static let help = L10n.tr("Localizable", "checklist.view.signature.help")
                internal enum Error {
                    /// Please Sign
                    internal static let message = L10n.tr("Localizable", "checklist.view.signature.error.message")
                    /// Signature not present
                    internal static let title = L10n.tr("Localizable", "checklist.view.signature.error.title")
                }
            }

            internal enum Url {
                /// Not Visited
                internal static let notVisited = L10n.tr("Localizable", "checklist.view.url.notVisited")
                /// Visited
                internal static let visited = L10n.tr("Localizable", "checklist.view.url.visited")
            }
        }
    }

    internal enum Common {
        /// Add
        internal static let add = L10n.tr("Localizable", "common.add")
        /// Cancel
        internal static let cancel = L10n.tr("Localizable", "common.cancel")
        /// Continue
        internal static let `continue` = L10n.tr("Localizable", "common.continue")
        /// Dismiss
        internal static let dimiss = L10n.tr("Localizable", "common.dimiss")
        /// Done
        internal static let done = L10n.tr("Localizable", "common.done")
        /// Error
        internal static let error = L10n.tr("Localizable", "common.error")
        /// Okay
        internal static let okay = L10n.tr("Localizable", "common.okay")
        /// required
        internal static let required = L10n.tr("Localizable", "common.required")
        /// Submit
        internal static let submit = L10n.tr("Localizable", "common.submit")
        /// Type here...
        internal static let typeHere = L10n.tr("Localizable", "common.typeHere")
    }

    internal enum Error {
        internal enum Image {
            /// Failed to save image. Please try again
            internal static let save = L10n.tr("Localizable", "error.image.save")
        }

        internal enum Scan {
            /// Scan is not supported on this version of the OS
            internal static let notSupported = L10n.tr("Localizable", "error.scan.notSupported")
        }
    }

    internal enum Permissions {
        internal enum Camera {
            internal enum Alert {
                /// Dismiss
                internal static let dismiss = L10n.tr("Localizable", "permissions.camera.alert.dismiss")
                /// To enable access, go to Settings > Camera and turn on Camera access for the app.
                internal static let message = L10n.tr("Localizable", "permissions.camera.alert.message")
                /// Settings
                internal static let settings = L10n.tr("Localizable", "permissions.camera.alert.settings")
                /// Unable to access the Camera
                internal static let title = L10n.tr("Localizable", "permissions.camera.alert.title")
            }
        }
    }

    internal enum Scanner {
        internal enum View {
            /// Scanner
            internal static let title = L10n.tr("Localizable", "scanner.view.title")
        }
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Foundation.Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle = Bundle.getFrameworkBundle()
}

// swiftlint:enable convenience_type
