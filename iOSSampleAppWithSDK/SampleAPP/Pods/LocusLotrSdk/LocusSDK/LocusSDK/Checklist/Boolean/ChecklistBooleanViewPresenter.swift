import Foundation
import UIKit
class ChecklistBooleanViewPresenter: ChecklistItemPresenter {

    private var view: ChecklistBooleanView!
    private let checklistItem: ChecklistItem

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {
        view = ChecklistBooleanView.loadViewFromNib()
        view?.title.text = checklistItem.item
        return view!
    }

    func validate() -> Bool {
        return true
    }

    func extractValue() throws -> (String, String)? {
        let selected = view.userInput.isOn
        return (checklistItem.key!, "\(selected)")
    }

    func setValue(_ initialValue: String?) {
        if let isSelectedString = initialValue, let isSelected = Bool(isSelectedString) {
            view.userInput.isOn = isSelected
        }
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.boolean
    }
}
