import Foundation
import UIKit

class ChecklistURLViewPresenter: ChecklistItemPresenter {

    private var viewController: UIViewController!
    private var view: ChecklistURLView!
    private var checklistItem: ChecklistItem!

    init(checklistItem: ChecklistItem, viewController: UIViewController) {
        self.checklistItem = checklistItem
        self.viewController = viewController
    }

    func createView() -> UIView {
        view = ChecklistURLView.loadViewFromNib()
        view.urlHeadingView.title.text = checklistItem.item
        view.urlHeadingView.isOptional = checklistItem._optional
        view.urlLabel.attributedText = NSAttributedString(string: checklistItem.possibleValues?.first ?? "https://locus.sh", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        view.verifiedLabel.isHidden = true
        view.checkBox.isHidden = true
        view.webCLickButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return view
    }

    @objc func buttonClicked() {
        let webView = LocusSDKWebView()
        webView.loadWebView(withURL: self.checklistItem.possibleValues?.first ?? "https://locus.sh")
        setVisited()
    }

    func setVisited() {
        self.view.checkBox.isChecked = true
        self.view.verifiedLabel.text = L10n.Checklist.View.Url.visited
        self.view.verifiedLabel.textColor = UIColor.AppColor.Green.Cool
        if let tipView = self.view.urlHeadingView.tipView {
            tipView.dismiss()
        }
    }

    func validate() -> Bool {
        if !checklistItem._optional!, !view.checkBox.isChecked {
            view.urlHeadingView.displayErrorWithString(error: L10n.Checklist.Error.url(checklistItem.item!))
            return false
        }
        return true
    }

    func extractValue() throws -> (String, String)? {
        if !checklistItem._optional!, !view.checkBox.isChecked {
            throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.url(checklistItem.item!))
        }
        return (checklistItem.key!, "\(view.checkBox.isChecked)")
    }

    func setValue(_ initialValue: String?) {
        if let isSelectedString = initialValue, let isSelected = Bool(isSelectedString) {
            if isSelected {
                setVisited()
            }
        }
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.url
    }
}
