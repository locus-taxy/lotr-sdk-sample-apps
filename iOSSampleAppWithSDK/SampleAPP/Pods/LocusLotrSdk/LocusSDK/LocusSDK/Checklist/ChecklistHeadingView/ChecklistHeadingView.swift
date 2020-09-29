import Foundation
import Reusable
import UIKit

class ChecklistHeadingView: UIView, NibOwnerLoadable {

    @IBOutlet var title: UILabel!
    @IBOutlet var rightStack: UIStackView!
    @IBOutlet var requiredLabel: UILabel!
    @IBOutlet var alertImage: UIImageView!
    var tipView: EasyTipView?
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var bottomLine: UIView!
    @IBOutlet var topLine: UIView!

    var isOptional: Bool? = false {
        didSet {
            updateIsRequiredView()
        }
    }

    func initializeView() {
        backgroundColor = UIColor.AppColor.Grey.Light
        title.updateStyle(styles: [fontType.bold, fontSizes.normal])
        rightStack.isHidden = true
        requiredLabel.isHidden = true
        let attributedText = NSMutableAttributedString(string: "*", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.AppColor.Grey.Charcoal,
            NSAttributedString.Key.font: UIFont.fontWith(size: fontSizes.large, type: .bold),
        ])
        attributedText.append(NSAttributedString(string: "(\(L10n.Common.required))", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.AppColor.Grey.Charcoal.withAlphaComponent(0.5),
            NSAttributedString.Key.font: UIFont.fontWith(size: fontSizes.ultraSmall, type: .normal),
        ]))
        requiredLabel.attributedText = attributedText
        alertImage.isHidden = true
        rightButton.isHidden = true
        bottomLine.backgroundColor = UIColor.AppColor.Grey.Line
        topLine.backgroundColor = UIColor.AppColor.Grey.Line
    }

    func displayErrorWithString(error: String) {
        self.requiredLabel.isHidden = true
        self.alertImage.isHidden = false
        if tipView != nil {
            return
        }
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont.fontWith(size: fontSizes.normal, type: fontType.normal)
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = LocusSDK.tintColour
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        preferences.positioning.maxWidth = 300
        preferences.animating.showDuration = 0.7
        preferences.drawing.borderColor = UIColor.white.withAlphaComponent(0.4)
        preferences.drawing.borderWidth = 1
        preferences.drawing.shadowColor = UIColor.black.withAlphaComponent(0.24)
        preferences.drawing.shadowOffset = CGSize(width: 0, height: 2)
        preferences.drawing.shadowRadius = 2
        preferences.drawing.textAlignment = .center
        tipView = EasyTipView(text: error, preferences: preferences, delegate: self)
        tipView!.show(forView: alertImage, withinSuperview: self.superview?.superview)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.tipView?.handleRotation()
        }
    }

    private func updateIsRequiredView() {
        self.requiredLabel.isHidden = isOptional ?? true
        updateRightStack()
    }

    private func updateRightStack() {
        rightStack.isHidden = rightStack.arrangedSubviews.first { $0.isHidden == false } == nil
    }

    func addToSubview(view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0).isActive = true
    }
}

extension ChecklistHeadingView: EasyTipViewDelegate {
    func easyTipViewDidDismiss(_: EasyTipView) {
        tipView = nil
        self.requiredLabel.isHidden = false
        self.alertImage.isHidden = true
    }
}
