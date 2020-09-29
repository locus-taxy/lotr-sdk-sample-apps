import KeyboardAvoidingView
import Moya
import UIKit

class ChecklistViewController: UIViewController {

    var checklist: Checklist!
    var completionHandler: ((ChecklistResult) -> Void)?
    var initialValues: [String: String]?
    var displayConfig: LocusSDKChecklistDisplayConfig!
    private var checklistManager: ChecklistManager?

    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet var dismissButton: UIBarButtonItem?
    @IBOutlet var doneButton: UIBarButtonItem?

    @IBOutlet var background: UIView?
    @IBOutlet var sliderView: UIView?
    @IBOutlet var sliderImage: UIImageView?
    @IBOutlet var detailsView: UIView!
    @IBOutlet var labelsStack: UIStackView!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var closeButton: UIButton?
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewHeight: NSLayoutConstraint?
    @IBOutlet var topViewHeight: NSLayoutConstraint?
    @IBOutlet var checkListView: UIStackView!
    @IBOutlet var submitButton: UIButton?

    override func viewDidLoad() {

        super.viewDidLoad()

        checklistManager = ChecklistManagerImpl(checklist: checklist, stackView: checkListView, viewController: self)
        checklistManager?.render(initialValues: initialValues ?? [:])
        initializeView()
    }

    func initializeView() {

        self.view.backgroundColor = UIColor.AppColor.Black.Max20
        self.background?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:))))
        self.sliderView?.topCornerRadius = 10
        closeButton?.setImage(ResourceHelper.clear, for: .normal)
        closeButton?.alpha = 0.85

        if let navigationBar = navigationBar {
            UIUtil.configureNavigationBar(navigationBar: navigationBar)
            navigationBar.topItem?.title = L10n.Checklist.View.title
        }
        dismissButton?.title = L10n.Common.dimiss
        doneButton?.title = L10n.Common.done
        dismissButton?.action = #selector(closeButtonTapped(_:))
        doneButton?.action = #selector(saveButtonTapped(_:))

        detailsLabel.updateStyle(styles: [])
        detailsLabel.text = displayConfig.subtitle
        if let attributedSubTitle = displayConfig.attributedSubtitle {
            detailsLabel.attributedText = attributedSubTitle
        }
        headingLabel.updateStyle(styles: [fontType.bold, fontSizes.medium])
        headingLabel.text = displayConfig.title
        if let attributedTitle = displayConfig.attributedTitle {
            headingLabel.attributedText = attributedTitle
        }

        self.view.layoutIfNeeded()
        let stackViewHeight = checkListView.frame.size.height
        let viewHeight = getViewHeight()
        scrollViewHeight?.constant = stackViewHeight < viewHeight ? stackViewHeight : viewHeight
        submitButton?.backgroundColor = LocusSDK.tintColour
        submitButton?.layer.cornerRadius = 5.0
        submitButton?.clipsToBounds = true
        submitButton?.setTitle(displayConfig.buttonTitle, for: .normal)
    }

    private func getViewHeight() -> CGFloat {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            return self.view.frame.size.height - 200
        }
        return self.view.frame.size.height - 240
    }

    // MARK: - Actions

    override func viewDidLayoutSubviews() {
        initializeView()
    }

    override func viewWillLayoutSubviews() {
        if displayConfig.type == .fullScreen {
            self.topViewHeight?.constant = self.view.bounds.size.height > self.view.bounds.size.width ? 44 : 32
        }
    }

    @IBAction func closeButtonTapped(_: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonTapped(_: Any) {

        do {
            let checklistValues = try checklistManager?.extractChecklistValues()
            dismiss(animated: true, completion: {
                self.completionHandler!(checklistValues!)
            })
        } catch {
            return
        }
    }
}
