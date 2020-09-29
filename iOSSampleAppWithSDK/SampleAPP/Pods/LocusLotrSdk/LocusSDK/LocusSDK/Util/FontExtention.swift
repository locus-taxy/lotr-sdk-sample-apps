import Foundation
import UIKit

enum fontSizes: CGFloat {
    case ultraSmall = 11.0
    case small = 13.0
    case normal = 15.0
    case medium = 17.0
    case large = 20.0
    case huge = 28.0
}

enum fontType: String {
    case normal = "SFProText-Regular"
    case bold = "SFProText-Medium"
}

enum fontTransperency: CGFloat {
    case primary = 1.0
    case secondary = 0.75
    case tertiary = 0.5
}

enum fontMode {
    case dark
    case light
    case colored(color: UIColor)
}

enum labelStyle {
    case normal
}

extension UIFont {
    static func fontWith(size: fontSizes = .normal, type: fontType = .normal) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size.rawValue) ?? (type == .normal ? UIFont.systemFont(ofSize: size.rawValue) : UIFont.boldSystemFont(ofSize: size.rawValue))
        return font
    }

    func withTraits(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}

extension UILabel {
    private func colorForMode(mode: fontMode) -> UIColor {
        switch mode {
            case .dark:
                return UIColor.AppColor.Grey.Charcoal
            case .light:
                return UIColor.AppColor.White.Light
            case let .colored(color):
                return color
        }
    }

    private func setlabelStyle(style: labelStyle, _ font: UIFont = UIFont.fontWith(size: .normal, type: .normal)) {
        self.font = font
        switch style {
            case .normal:
                self.font = UIFont.fontWith(size: .normal, type: .normal)
                self.textColor = self.colorForMode(mode: .dark)
                self.textColor.withAlphaComponent(fontTransperency.primary.rawValue)
        }
    }

    func setHTMLText(text: String) {
        guard let data = text.data(using: String.Encoding.unicode) else {
            self.text = text
            return
        }
        do {
            self.text = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string
        } catch {
            self.text = text
        }
    }

    func updateStyle(styles: [Any]) {
        self.setlabelStyle(style: .normal)
        for item in styles {
            if let fontSize = item as? fontSizes {
                self.font = self.font.withSize(fontSize.rawValue)
            }
            if let fontType = item as? fontType {
                self.font = UIFont(name: fontType.rawValue, size: self.font.pointSize)
                if fontType == .bold {
                    self.font = self.font.bold()
                }
            }
            if let fontMode = item as? fontMode {
                self.textColor = self.colorForMode(mode: fontMode)
            }
            if let fontTransperency = item as? fontTransperency {
                self.textColor = self.textColor.withAlphaComponent(fontTransperency.rawValue)
            }
        }
    }
}

var placeHolderTextAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key.foregroundColor: UIColor.AppColor.Grey.Charcoal.withAlphaComponent(0.5),
    NSAttributedString.Key.font: UIFont.fontWith(size: fontSizes.normal, type: .normal),
]
