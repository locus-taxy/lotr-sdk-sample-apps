import UIKit

class ChecklistTextFieldView: UIView {

    @IBOutlet var headingView: UIView!
    var textFieldHeadingView: ChecklistHeadingView!
    var textFieldPresenter: ChecklistItemPresenter?
    @IBOutlet var userInput: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        initializeView()
    }

    func initializeView() {
        headingView.backgroundColor = UIColor.AppColor.Grey.Light
        textFieldHeadingView = ChecklistHeadingView.loadViewFromNib()
        textFieldHeadingView.addToSubview(view: headingView)
        textFieldHeadingView.initializeView()
        textFieldHeadingView.rightStack.isHidden = false
        textFieldHeadingView.rightButton.isHidden = false
        textFieldHeadingView.rightButton.contentMode = .center
        textFieldHeadingView.rightButton.contentMode = .center
        textFieldHeadingView.rightButton.imageView?.contentMode = .scaleAspectFit
        textFieldHeadingView.rightButton.setImage(ResourceHelper.scanImage, for: .normal)
        textFieldHeadingView.rightButton.addTarget(self, action: #selector(scanButtonClicked(_:)), for: .touchUpInside)
        userInput.delegate = self
        userInput.attributedPlaceholder = NSAttributedString(string: "\(L10n.Common.typeHere)",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.AppColor.Grey.Line])
        userInput.textColor = UIColor.AppColor.Grey.Charcoal
    }

    @IBAction func scanButtonClicked(_: Any) {
        if #available(iOS 10.0, *) {
            CameraPermission.checkCameraPermission(onSuccess: {
                let scanView = AppStoryboard.scanner.viewController(viewControllerClass: ScannerViewController.self)
                scanView.modalPresentationStyle = .fullScreen
                scanView.scannerDelegate = self
                UIApplication.topViewController()?.present(scanView, animated: true, completion: {})
            }) {}
        } else {
            Messages.showAlert(title: L10n.Common.error, message: L10n.Error.Scan.notSupported) {}
        }
    }
}

extension ChecklistTextFieldView: UITextFieldDelegate {

    func textFieldDidEndEditing(_: UITextField) {
        _ = self.textFieldPresenter?.validate()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ChecklistTextFieldView: ScannerDelegate {
    func scannerDidScanWith(data scanData: String) {
        userInput.text = "\(userInput.text ?? "") \(scanData)"
    }

    func scannerDidCancel() {}
}
