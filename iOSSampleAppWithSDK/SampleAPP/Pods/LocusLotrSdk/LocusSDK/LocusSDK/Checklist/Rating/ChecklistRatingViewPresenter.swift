import Cosmos
import Foundation

class ChecklistRatingViewPresenter: ChecklistItemPresenter {

    private var view: ChecklistRatingView?
    private var checklistItem: ChecklistItem!

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {
        view = ChecklistRatingView.loadViewFromNib()
        view?.ratingHeadingView.title.text = checklistItem.item
        view?.ratingHeadingView.isOptional = checklistItem._optional
        view?.rating.settings.totalStars = Int(checklistItem.possibleValues?.first ?? "5")!
        return view!
    }

    func validate() -> Bool {
        guard let rating = view?.rating.rating else {
            if !checklistItem._optional! {
                view?.ratingHeadingView.displayErrorWithString(error: L10n.Checklist.Error.ratingAbsent(checklistItem.item!))
                return false
            }
            return true
        }
        if checklistItem._optional!, rating == 0 {
            return true
        }
        if let possibleValue = checklistItem.possibleValues?.first {
            if (Double(possibleValue) ?? 0.0) > 0.0, rating <= 0.0 {
                view?.ratingHeadingView.displayErrorWithString(error: L10n.Checklist.Error.ratingZero(checklistItem.item!))
                return false
            }
        }
        return true
    }

    func extractValue() throws -> (String, String)? {
        guard let rating = view?.rating.rating else {
            if !checklistItem._optional! {
                throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.ratingAbsent(checklistItem.item!))
            }
            return nil
        }
        if checklistItem._optional!, rating == 0 {
            return nil
        }
        if let possibleValue = checklistItem.possibleValues?.first {
            if (Double(possibleValue) ?? 0.0) > 0.0, rating <= 0.0 {
                throw LocusSDKError.inputInvalid(message: L10n.Checklist.Error.ratingZero(checklistItem.item!))
            }
        }
        return (checklistItem.key!, "\(rating)")
    }

    func setValue(_ initialValue: String?) {
        if let ratingString = initialValue, let rating = Double(ratingString) {
            self.view?.rating.rating = rating
        }
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.rating
    }
}
