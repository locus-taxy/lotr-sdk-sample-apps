import Foundation
import UIKit

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        var viewController = controller

        if controller == nil {
            viewController = UIApplication.shared.keyWindow?.rootViewController
        }
        if let navigationController = viewController as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = viewController as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(controller: presented)
        }
        return viewController
    }
}

extension Bundle {

    static func getFrameworkBundle() -> Bundle {

        let frameworkBundle = Bundle(for: ChecklistViewController.self)
        if frameworkBundle.path(forResource: "Checklist", ofType: "storyboardc") != nil {
            return frameworkBundle
        }
        if let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("LocusLotrSdk.bundle"), let resourceBundle = Bundle(url: bundleURL) {
            if resourceBundle.path(forResource: "Checklist", ofType: "storyboardc") != nil {
                return resourceBundle
            }
        }
        return Bundle.main
    }
}

enum AppStoryboard: String {

    case main = "Main"
    case checklist = "Checklist"
    case scanner = "Scanner"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.getFrameworkBundle())
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {

            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }

        return scene
    }

    func initialViewController() -> UIViewController? {

        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {

    // MARK: - Instantiation:

    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {

        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {

        return appStoryboard.viewController(viewControllerClass: self)
    }
}
