import Foundation
import UIKit

extension String {

    var titleCase: String {
        let result = self.components(separatedBy: " ")
        let titled = result.map { (string) -> String in
            string.capitalizingFirstLetter()
        }
        return titled.joined(separator: " ")
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst().localizedLowercase
    }

    // MARK: - Regex

    /*
     example
     "prefix12 aaa3 prefix45".matchingStrings(regex: "fix([0-9])([0-9])")
     -> [["fix12", "1", "2"], ["fix45", "4", "5"]]
     */
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else {
            return []
        }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0 ..< result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }

    func matches(regex: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else {
            return false
        }
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
