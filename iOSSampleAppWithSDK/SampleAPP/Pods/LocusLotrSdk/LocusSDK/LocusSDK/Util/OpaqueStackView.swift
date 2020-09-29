import UIKit

/** A stack view that can display a background color
 */
class OpaqueStackView: UIStackView {

    private var color: UIColor?

    @IBInspectable
    override var backgroundColor: UIColor? {

        get {
            return color
        }

        set {
            color = newValue
            self.setNeedsLayout()
        }
    }

    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}
