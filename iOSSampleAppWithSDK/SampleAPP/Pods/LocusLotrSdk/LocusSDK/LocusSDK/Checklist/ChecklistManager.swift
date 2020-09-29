import UIKit

class ChecklistManagerImpl: ChecklistManager {

    private let checklist: Checklist
    private let stackView: UIStackView
    private var viewController: UIViewController?
    private var itemPresenters = [ChecklistItemPresenter]()

    init(checklist: Checklist, stackView: UIStackView, viewController: UIViewController) {

        self.checklist = checklist
        self.stackView = stackView
        self.viewController = viewController
    }

    func render(initialValues: [String: String]) {

        guard let viewController = viewController else {
            return
        }

        clearState()

        for checklistItem in checklist.items ?? [ChecklistItem]() {

            if let presenter = ChecklistItemPresenterFactory.create(item: checklistItem, viewController: viewController) {
                stackView.addArrangedSubview(presenter.createView())
                if let key = checklistItem.key, let value = initialValues[key] {
                    presenter.setValue(value)
                }
                itemPresenters.append(presenter)
            }
        }
    }

    private func clearState() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        itemPresenters = [ChecklistItemPresenter]()
    }

    func extractChecklistValues() throws -> ChecklistResult {
        var checkListIsValid: [Bool] = []
        var checklistItemResults: [ChecklistItemResult] = []

        for presenter in itemPresenters {
            checkListIsValid.append(presenter.validate())
        }

        if checkListIsValid.contains(false) {
            throw LocusSDKError.general(message: "Checklist Invalid")
        }

        for presenter in itemPresenters {
            if let pair = try presenter.extractValue() {
                checklistItemResults.append(ChecklistItemResult(key: pair.0, value: pair.1, type: presenter.format()))
            }
        }
        return ChecklistResult(results: checklistItemResults)
    }
}

protocol ChecklistManager {

    func render(initialValues: [String: String])

    func extractChecklistValues() throws -> ChecklistResult
}
