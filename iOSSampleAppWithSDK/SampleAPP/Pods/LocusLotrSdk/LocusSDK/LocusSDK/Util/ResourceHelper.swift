import Foundation
import UIKit

class ResourceHelper {
    private class func getImage(name: String) -> UIImage {
        if let image = UIImage(named: name) {
            return image
        }
        return UIImage(named: name, in: Bundle.getFrameworkBundle(), compatibleWith: nil)!
    }

    class var checkBoxSelected: UIImage {
        return getImage(name: "checkBoxSelected")
    }

    class var checkBoxUnSelected: UIImage {
        return getImage(name: "checkBoxUnselected")
    }

    class var checklistPhoto: UIImage {
        return getImage(name: "checklistPhoto")
    }

    class var checklistSignature: UIImage {
        return getImage(name: "checklistSignature")
    }

    class var scanImage: UIImage {
        return getImage(name: "scanImage")
    }

    class var clear: UIImage {
        return getImage(name: "clear")
    }
}
