import Foundation
import UIKit

/// Dispay type of the checklist
public enum LocusSDKChecklistDisplayType: String {
    /** Display checklist in fill screen with done and dismiss in the navigation bar on top of view */
    case fullScreen = "FullScreen"
    /** Display the checklist form the bottom as an overlay from the bottom with confirm bottom at the bottom of the view */
    case bottomView = "BottomView"

    var value: String {
        switch self {
            case .fullScreen:
                return "FullScreen"
            case .bottomView:
                return "BottomView"
        }
    }
}

/// All the parameters that can be configured when the checklist view is being displayed
public struct LocusSDKChecklistDisplayConfig {

    /** title of the checklist to be displayed */
    let title: String?
    /** subtitle of checklist to be displayed */
    let subtitle: String?
    /** title of the button to be displayed */
    let buttonTitle: String?
    /** This will override the title and show the attributed text as title */
    let attributedTitle: NSAttributedString?
    /** This will override the subtitle and show the attributed text as subtitle */
    let attributedSubtitle: NSAttributedString?
    /** The type of checklist to be displayed it is bottom view by default */
    let type: LocusSDKChecklistDisplayType
    /** Flag to indicate weather keyboard Avoiding is to be handled **/
    let handleKeybordAvoiding: Bool

    /// Init
    ///
    /// - Parameters:
    ///   - title: title of the checklist to be displayed
    ///   - subtitle: subtitle of checklist to be displayed
    ///   - buttonTitle: title of the button to be displayed
    ///   - attributedTitle: This will override the title and show the attributed text as title
    ///   - attributedSubtitle: This will override the subtitle and show the attributed text as subtitle
    ///   - type: The type of checklist to be displayed it is bottom view by default
    public init(title: String?, subtitle: String?, buttonTitle: String?, attributedTitle: NSAttributedString?, attributedSubtitle: NSAttributedString?, type: LocusSDKChecklistDisplayType = .bottomView, handleKeybordAvoiding: Bool = true) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.attributedTitle = attributedTitle
        self.attributedSubtitle = attributedSubtitle
        self.type = type
        self.handleKeybordAvoiding = handleKeybordAvoiding
    }

    static func defaultConfig() -> LocusSDKChecklistDisplayConfig {
        return LocusSDKChecklistDisplayConfig(title: L10n.Checklist.View.title, subtitle: L10n.Checklist.View.subtitle, buttonTitle: L10n.Common.submit, attributedTitle: nil, attributedSubtitle: nil)
    }
}
