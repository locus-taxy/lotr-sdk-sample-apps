import Foundation
import UIKit

class AppUtil {

    class func isOlderThanSecs(time: Int64, seconds: Int) -> Bool {
        return Date().milliSecondsSinceEpoch - time > seconds * 1000
    }

    private class func getValueInPlist(forKey key: String) -> String? {
        let mainBundleProperties = Bundle.main.infoDictionary
        guard let value = mainBundleProperties?[key] else {
            return nil
        }
        return value as? String
    }

    private class func getVersion() -> String {
        return getValueInPlist(forKey: "CFBundleShortVersionString") ?? "1.0.0"
    }

    private class func getBuild() -> String {
        return getValueInPlist(forKey: "CFBundleVersion") ?? "0"
    }

    class func getAppVersion() -> String {
        return "\(getVersion()) (\(getBuild()))"
    }

    class func checkPlistStringForLocationServices() -> Bool {
        if getValueInPlist(forKey: "NSLocationAlwaysAndWhenInUseUsageDescription") != nil, getValueInPlist(forKey: "NSLocationWhenInUseUsageDescription") != nil {
            return true
        }
        return false
    }
}

class UIUtil {

    class func configureNavigationBar(navigationBar: UINavigationBar) {
        navigationBar.barTintColor = LocusSDK.tintColour
        navigationBar.tintColor = UIColor.AppColor.White.Light
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColor.White.Light]
        navigationBar.titleTextAttributes = textAttributes
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = textAttributes
        }
        navigationBar.barStyle = .blackTranslucent
        navigationBar.isTranslucent = false
    }
}
