import Foundation
import UIKit

class ChecklistPinView: UIView {

    @IBOutlet var headingView: UIView!
    var pinHeadingView: ChecklistHeadingView!
    var pinViewPresenter: ChecklistItemPresenter?
    @IBOutlet var pinEntryView: CBPinEntryView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializeView()
    }

    func initializeView() {
        self.headingView.backgroundColor = UIColor.AppColor.Grey.Light
        pinHeadingView = ChecklistHeadingView.loadViewFromNib()
        pinHeadingView.addToSubview(view: headingView)
        pinHeadingView.initializeView()
        self.pinEntryView.isSecure = false
        self.pinEntryView.entryTextColour = UIColor.AppColor.Black.Clear
        self.pinEntryView.length = 4
        self.pinEntryView.spacing = 10
        self.pinEntryView.entryDefaultBorderColour = UIColor.AppColor.Grey.Charcoal
        self.pinEntryView.entryBorderColour = LocusSDK.tintColour
        self.pinEntryView.entryTextColour = UIColor.AppColor.Black.Max
        self.pinEntryView.delegate = self
    }
}

extension ChecklistPinView: CBPinEntryViewDelegate {
    func entryChanged(_: Bool) {
        if self.pinEntryView.getPinAsString() == nil || self.pinEntryView.getPinAsString()?.count == self.pinEntryView.length {
            _ = self.pinViewPresenter?.validate()
            self.pinEntryView.resignFirstResponder()
        }
    }
}
