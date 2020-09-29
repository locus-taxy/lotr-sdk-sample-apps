import Foundation
import UIKit

class ChecklistURLView: UIView {

    @IBOutlet var headingView: UIView!
    var urlHeadingView: ChecklistHeadingView!
    @IBOutlet var viewStack: UIStackView!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var checkBox: CheckBoxButton!
    @IBOutlet var verifiedLabel: UILabel!
    @IBOutlet var webCLickButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        initializeView()
    }

    private func initializeView() {
        self.headingView.backgroundColor = UIColor.AppColor.Grey.Light
        urlHeadingView = ChecklistHeadingView.loadViewFromNib()
        urlHeadingView.addToSubview(view: self.headingView)
        urlHeadingView.initializeView()
        self.viewStack.backgroundColor = UIColor.white
        self.checkBox.isChecked = false
        self.verifiedLabel.text = L10n.Checklist.View.Url.notVisited
        self.urlLabel.text = L10n.Checklist.View.url
        self.urlLabel.textColor = LocusSDK.tintColour
    }
}
