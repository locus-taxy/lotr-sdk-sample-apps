import UIKit

extension UIColor {

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb = Int(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255) << 0

        return String(format: "#%06x", rgb)
    }

    /**
     Creates an UIColor from HEX String in "#363636" format

     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {

        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    /**
     Creates an UIColor Object based on provided RGB value in integer
     - parameter red:   Red Value in integer (0-255)
     - parameter green: Green Value in integer (0-255)
     - parameter blue:  Blue Value in integer (0-255)
     - returns: UIColor with specified RGB values
     */
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
}

// MARK: - Color Values

extension UIColor {

    struct AppColor {

        struct White {
            static let Light = UIColor(red: 255, green: 255, blue: 255)
            static let Translucent50 = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
            static let One = UIColor(red: 235, green: 235, blue: 235)
            static let Two = UIColor(red: 233, green: 233, blue: 233)
            static let Three = UIColor(red: 231, green: 231, blue: 231)
        }

        struct Grey {
            static let Charcoal = UIColor(red: 56, green: 63, blue: 71)
            static let CharcoalTranslucent50 = UIColor(red: 56, green: 63, blue: 71, alpha: 0.5)
            static let DarkGrey = UIColor(red: 34, green: 34, blue: 34)
            static let Pale = UIColor(red: 247, green: 249, blue: 251)
            static let Background = UIColor(red: 207, green: 207, blue: 207)
            static let Light = UIColor(red: 240, green: 241, blue: 245)
            static let Line = UIColor(red: 188, green: 187, blue: 193).withAlphaComponent(0.5)
            static let LightLine = UIColor(red: 200, green: 199, blue: 204)
        }

        struct Blue {
            static let Azure = UIColor(red: 0, green: 157, blue: 255)
            static let BrightSky = UIColor(red: 0, green: 200, blue: 255)
            static let Bright = UIColor(red: 0, green: 110, blue: 255)
            static let Dark = UIColor(red: 0, green: 111, blue: 203)
        }

        struct Green {
            static let LightCool = UIColor(red: 66, green: 255, blue: 123)
            static let Cool = UIColor(red: 52, green: 202, blue: 98)
            static let Tealish = UIColor(red: 0, green: 222, blue: 107)
            static let TealishTwo = UIColor(red: 10, green: 204, blue: 95)
            static let Teal = UIColor(red: 19, green: 189, blue: 86)
        }

        struct Red {
            static let Coral = UIColor(red: 250, green: 83, blue: 83)
            static let Salmon = UIColor(red: 255, green: 102, blue: 102)
            static let OrangeyRed = UIColor(red: 246, green: 62, blue: 62)
            static let lightOrangey = UIColor(red: 255, green: 146, blue: 102)
        }

        struct Black {
            static let Max = UIColor(red: 0, green: 0, blue: 0)
            static let Max20 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            static let Max60pc = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            static let Clear = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.0)
            static let Background = UIColor(red: 32, green: 36, blue: 41, alpha: 0.0)
        }
    }
}
