import Foundation
import UIKit

class ChecklistDateTimePresenter: ChecklistItemPresenter {

    private var view: ChecklistDateTimeView?
    private let checklistItem: ChecklistItem

    private let dateFormat = "yyyy-MM-dd"
    private let timeFormat = "HH:mm:ss"
    private let dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss"

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {
        view = ChecklistDateTimeView.loadViewFromNib()
        view?.format = checklistItem.format
        view?.checklistHeadingView.title.text = checklistItem.item
        view?.checklistHeadingView.isOptional = checklistItem._optional
        return view!
    }

    private func validateDate() -> Bool {
        guard (view?.selectedDate) != nil else {
            if !checklistItem._optional! {
                view?.checklistHeadingView.displayErrorWithString(error: L10n.Checklist.Error.boolean(checklistItem.item!))
                return false
            }
            return true
        }
        if let tipView = self.view?.checklistHeadingView.tipView {
            tipView.dismiss()
        }
        return true
    }

    private func validateTime() -> Bool {
        guard (view?.selectedTime) != nil else {
            if !checklistItem._optional! {
                view?.checklistHeadingView.displayErrorWithString(error: L10n.Checklist.Error.boolean(checklistItem.item!))
                return false
            }
            return true
        }
        if let tipView = self.view?.checklistHeadingView.tipView {
            tipView.dismiss()
        }
        return true
    }

    func validate() -> Bool {
        if checklistItem.format! == .date {
            return validateDate()
        }
        if checklistItem.format! == .time {
            return validateTime()
        }
        if checklistItem.format! == .datetime {
            return validateDate() && validateTime()
        }
        return true
    }

    private func getFormattedDateString(date: Date, format: ChecklistItem.Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormat
        if format == .date {
            formatter.dateFormat = dateFormat
        } else if format == .time {
            formatter.dateFormat = timeFormat
        }
        return formatter.string(from: date)
    }

    private func getDateFromString(dateString: String, format: ChecklistItem.Format) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormat
        if format == .date {
            formatter.dateFormat = dateFormat
        } else if format == .time {
            formatter.dateFormat = timeFormat
        }
        return formatter.date(from: dateString)
    }

    func extractValue() throws -> (String, String)? {
        if checklistItem.format! == .date && view?.selectedDate == nil {
            return nil
        }
        if checklistItem.format! == .time && view?.selectedTime == nil {
            return nil
        }
        if checklistItem.format! == .datetime, view?.selectedDate == nil || view?.selectedTime == nil {
            return nil
        }
        guard let date = view?.datePicker.date else {
            return nil
        }
        let dateText = getFormattedDateString(date: date, format: checklistItem.format!)
        return (checklistItem.key!, dateText)
    }

    func setValue(_ dateString: String?) {
        guard let dateString = dateString, let date = getDateFromString(dateString: dateString, format: checklistItem.format!) else {
            return
        }
        view?.selectedDate = date
        view?.selectedTime = date
        view?.datePicker.date = date
        view?.setInitialValue()
    }

    func format() -> ChecklistItem.Format {
        return checklistItem.format!
    }
}
