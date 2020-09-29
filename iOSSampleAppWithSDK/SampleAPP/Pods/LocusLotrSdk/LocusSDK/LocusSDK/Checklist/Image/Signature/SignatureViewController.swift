import UIKit

class SignatureViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var titleItem: UINavigationItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var signatureView: YPDrawSignatureView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var helpLabel: UILabel!

    var signatureTitle: String!
    weak var delegate: SignatureViewControllerDelegate?

    override func viewDidLoad() {

        super.viewDidLoad()
        self.initializeView()
    }

    func initializeView() {
        UIUtil.configureNavigationBar(navigationBar: navigationBar)
        titleItem.title = signatureTitle
        setupNavigationButtons()
        clearButton.setImage(ResourceHelper.clear, for: .normal)
        helpLabel.updateStyle(styles: [fontSizes.normal, fontMode.colored(color: UIColor.AppColor.Grey.Charcoal)])
        helpLabel.text = L10n.Checklist.View.Signature.help
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return false
    }

    private func setupNavigationButtons() {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.AppColor.White.Light]
        doneButton.setTitleTextAttributes(attributes, for: .normal)
        doneButton.setTitleTextAttributes(attributes, for: .highlighted)
        doneButton.title = L10n.Common.done
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        cancelButton.setTitleTextAttributes(attributes, for: .highlighted)
        cancelButton.title = L10n.Common.cancel
    }

    @IBAction func clearTapped(_: Any) {
        signatureView.clear()
    }

    @IBAction func cancelTapped(_: Any) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func doneTapped(_: Any) {
        guard let signature = signatureView.getSignature() else {
            Messages.showAlert(title: L10n.Checklist.View.Signature.Error.title, message: L10n.Checklist.View.Signature.Error.message) {}
            return
        }

        delegate?.signatureViewDidCompleteSigning(image: signature)
        dismiss(animated: false, completion: nil)
    }
}

protocol SignatureViewControllerDelegate: class {

    func signatureViewDidCompleteSigning(image: UIImage?)
}
