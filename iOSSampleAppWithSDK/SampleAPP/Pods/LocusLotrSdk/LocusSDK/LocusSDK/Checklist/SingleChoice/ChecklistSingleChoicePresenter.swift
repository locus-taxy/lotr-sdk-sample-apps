import Foundation
import UIKit

class ChecklistSingleChoicePresenter: ChecklistItemPresenter {

    private var view: ChecklistSingleChoiceView?
    private let checklistItem: ChecklistItem

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {

        view = ChecklistSingleChoiceView.loadViewFromNib()
        view?.singleChoiceHeadingView.title.text = checklistItem.item
        view?.singleChoiceHeadingView.isOptional = checklistItem._optional
        view?.singleChoicePresenter = self
        view?.delegate = self
        view?.refresh()
        return view!
    }

    func validate() -> Bool {

        guard (view?.selectedRow) != nil else {
            if !checklistItem._optional! {
                view?.singleChoiceHeadingView.displayErrorWithString(error: L10n.Checklist.Error.singleChoice(checklistItem.item!))
                return false
            }
            return true
        }
        if let tipView = view?.singleChoiceHeadingView.tipView {
            tipView.dismiss()
        }
        return true
    }

    func extractValue() throws -> (String, String)? {

        guard let selectedRow = view?.selectedRow else {
            if !checklistItem._optional! {
                throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.singleChoice(checklistItem.item!))
            }
            return nil
        }

        let value = getValue(selectedIndex: selectedRow)
        return (checklistItem.key!, value)
    }

    func setValue(_ initialValue: String?) {
        guard let selectedValue = initialValue, let index = getSelectedIndex(value: selectedValue) else {
            return
        }
        view?.selectedRow = index
        view?.refresh()
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.singleChoice
    }

    private func getSelectedIndex(value: String) -> Int? {

        if checklistItem.allowedValues!.isEmpty {
            return checklistItem.possibleValues?.firstIndex(where: {
                $0 == value
            })
        }
        return checklistItem.allowedValues?.firstIndex(where: {
            $0.key == value
        })
    }

    private func getValue(selectedIndex: Int) -> String {

        if checklistItem.allowedValues!.isEmpty {
            return checklistItem.possibleValues![selectedIndex]
        }
        return checklistItem.allowedValues![selectedIndex].key!
    }

    private func getDisplayOptions() -> [String] {
        if checklistItem.allowedValues!.isEmpty {
            return checklistItem.possibleValues!
        }

        return checklistItem.allowedValues!.map { (allowedValue) -> String in
            allowedValue.value!
        }
    }
}

extension ChecklistSingleChoicePresenter: ChecklistSingleChoiceViewDelegate {

    func titleForRowAt(index: Int) -> String {
        return getDisplayOptions()[index]
    }

    func numberOfRows() -> Int {
        return getDisplayOptions().count
    }
}
