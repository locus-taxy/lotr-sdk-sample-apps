import Foundation
import UIKit

class Messages {

    class func showAlert(title: String?, message: String?, _ buttonTitle: String? = L10n.Common.okay, _ actionBlock: @escaping () -> Void) {

        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.view.tintColor = LocusSDK.tintColour
        alert.addAction(UIAlertAction(title: buttonTitle ?? "", style: .default, handler: { _ in
            actionBlock()
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: {})
    }

    class func showAlert(title: String?, message: String?, dismissButtonTitle: String?, confirmButtonTitle: String?, animated: Bool = true, dismissActionBlock: @escaping () -> Void, confirmActionBlock: @escaping () -> Void) {

        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.view.tintColor = UIColor.AppColor.Blue.Azure
        alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .default, handler: { _ in
            dismissActionBlock()
        }))
        alert.addAction(UIAlertAction(title: confirmButtonTitle ?? "", style: .default, handler: { _ in
            confirmActionBlock()
        }))
        UIApplication.topViewController()?.present(alert, animated: animated, completion: {})
    }
}
