import UIKit

protocol ChecklistItemPresenter {

    func createView() -> UIView

    func extractValue() throws -> (String, String)?

    func validate() -> Bool

    func setValue(_: String?)

    func format() -> ChecklistItem.Format
}
