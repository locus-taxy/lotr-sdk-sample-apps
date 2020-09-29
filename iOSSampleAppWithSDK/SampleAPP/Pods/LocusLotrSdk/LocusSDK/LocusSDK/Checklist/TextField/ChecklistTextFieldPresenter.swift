import UIKit

enum TextFieldType: String {

    case _default = "DEFAULT"
    case phone = "PHONE"
    case number = "NUMBER"
    case decimal = "DECIMAL"
    case email = "EMAIL_ADDRESS"
    case password = "PASSWORD"

    var KeyboardType: UIKeyboardType {

        switch self {

            case ._default:
                return .default

            case .phone:
                return .namePhonePad

            case .number:
                return .numberPad

            case .decimal:
                return .numbersAndPunctuation

            case .email:
                return .emailAddress

            case .password:
                return .default
        }
    }
}

class ChecklistTextFieldPresenter: ChecklistItemPresenter {

    private var view: ChecklistTextFieldView?
    private let checklistItem: ChecklistItem

    init(checklistItem: ChecklistItem) {
        self.checklistItem = checklistItem
    }

    func createView() -> UIView {
        view = ChecklistTextFieldView.loadViewFromNib()
        view?.textFieldHeadingView.title.text = checklistItem.item
        view?.textFieldHeadingView.isOptional = checklistItem._optional
        view?.textFieldPresenter = self
        if let inputOptionType = checklistItem.additionalOptions?["inputType"], let textFieldType = TextFieldType(rawValue: inputOptionType) {
            view?.userInput.keyboardType = textFieldType.KeyboardType
            if textFieldType == .password {
                view?.userInput.isSecureTextEntry = true
            }
        }
        return view!
    }

    func validate() -> Bool {

        guard let text = view?.userInput.text, !text.isEmpty else {

            if !checklistItem._optional! {
                view?.textFieldHeadingView.displayErrorWithString(error: L10n.Checklist.Error.textfield(checklistItem.item!))
                return false
            }
            return true
        }

        if let regex = checklistItem.additionalOptions?["regex"], let errorMessage = checklistItem.additionalOptions?["errorMessage"] {
            if !text.matches(regex: regex) {
                view?.textFieldHeadingView.displayErrorWithString(error: errorMessage)
                return false
            }
        }
        if let tipView = self.view?.textFieldHeadingView.tipView {
            tipView.dismiss()
        }
        return true
    }

    func extractValue() throws -> (String, String)? {

        guard let text = view?.userInput.text, !text.isEmpty else {

            if !checklistItem._optional! {
                throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.textfield(checklistItem.item!))
            }
            return nil
        }

        if let regex = checklistItem.additionalOptions?["regex"], let errorMessage = checklistItem.additionalOptions?["errorMessage"] {
            if !text.matches(regex: regex) {
                throw LocusSDKError.inputInvalid(message: errorMessage)
            }
        }

        return (checklistItem.key!, text)
    }

    func setValue(_ initialValue: String?) {
        if let text = initialValue {
            view?.userInput.text = text
        }
    }

    func format() -> ChecklistItem.Format {
        return ChecklistItem.Format.textField
    }
}
