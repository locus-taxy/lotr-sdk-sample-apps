import UIKit

class ChecklistSignaturePresenter: ChecklistImagePresenter {

    override var placeholderImage: UIImage {
        return ResourceHelper.checklistSignature
    }

    override var itemFormat: ChecklistItem.Format {
        return ChecklistItem.Format.signature
    }

    override func imageViewTapped() {
        let signatureViewController = SignatureViewController.instantiate(fromAppStoryboard: .checklist)
        signatureViewController.signatureTitle = checklistItem.item!
        signatureViewController.delegate = self
        signatureViewController.modalPresentationStyle = .fullScreen
        viewController?.present(signatureViewController, animated: true, completion: nil)
    }
}

extension ChecklistSignaturePresenter: SignatureViewControllerDelegate {

    func signatureViewDidCompleteSigning(image: UIImage?) {
        saveAndPreviewImage(image!)
        updateCaption()
    }
}
