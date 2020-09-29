import Foundation
import UIKit

class ChecklistPinViewPresenter: ChecklistItemPresenter {

    private var view: ChecklistPinView?
    private var checklistItem: ChecklistItem!

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {
        view = ChecklistPinView.loadViewFromNib()
        view?.pinEntryView.length = checklistItem.possibleValues?.first?.count ?? 4
        view?.pinHeadingView.title.text = checklistItem.item
        view?.pinHeadingView.isOptional = checklistItem._optional
        view?.pinViewPresenter = self

        return view!
    }

    func validate() -> Bool {
        guard let pin = view?.pinEntryView.getPinAsString() else {
            if !checklistItem._optional! {
                view?.pinHeadingView.displayErrorWithString(error: L10n.Checklist.Error.pinAbsent(checklistItem.item!))
                return false
            }
            if let tipView = view?.pinHeadingView.tipView {
                tipView.dismiss()
            }
            return true
        }
        if let possibleValues = checklistItem.possibleValues {
            if !possibleValues.contains(pin) {
                view?.pinHeadingView.displayErrorWithString(error: L10n.Checklist.Error.pinInvalid(checklistItem.item!))
                return false
            }
        }
        if let tipView = view?.pinHeadingView.tipView {
            tipView.dismiss()
        }
        return true
    }

    func extractValue() throws -> (String, String)? {
        guard let pin = view?.pinEntryView.getPinAsString() else {
            if !checklistItem._optional! {
                throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.pinAbsent(checklistItem.item!))
            }
            return nil
        }
        if let possibleValues = checklistItem.possibleValues {
            if !possibleValues.contains(pin) {
                throw LocusSDKError.inputInvalid(message: L10n.Checklist.Error.pinInvalid(checklistItem.item!))
            }
        }
        return (checklistItem.key!, pin)
    }

    func setValue(_ initialValue: String?) {
        self.view?.pinEntryView.setPinAsString(initialValue: initialValue ?? "")
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.pin
    }
}
