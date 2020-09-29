import Foundation
import UIKit

class ChecklistItemPresenterFactory {

    class func create(item: ChecklistItem, viewController: UIViewController) -> ChecklistItemPresenter? {

        guard let itemFormat = item.format else {
            return nil
        }

        switch itemFormat {

            case .textField:
                return ChecklistTextFieldPresenter(checklistItem: item)

            case .boolean:
                return ChecklistBooleanViewPresenter(checklistItem: item)

            case .singleChoice:
                return ChecklistSingleChoicePresenter(checklistItem: item)

            case .pin:
                return ChecklistPinViewPresenter(checklistItem: item)

            case .signature:
                return ChecklistSignaturePresenter(checklistItem: item, viewController: viewController)

            case .photo:
                return ChecklistPhotoPresenter(checklistItem: item, viewController: viewController)

            case .rating:
                return ChecklistRatingViewPresenter(checklistItem: item)

            case .url:
                return ChecklistURLViewPresenter(checklistItem: item, viewController: viewController)

            case .date, .time, .datetime:
                return ChecklistDateTimePresenter(checklistItem: item)
        }
    }
}
