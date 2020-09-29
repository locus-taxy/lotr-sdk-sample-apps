import UIKit

class ChecklistImagePresenter: NSObject, ChecklistItemPresenter {

    let Tag = "\(String(describing: self))"

    var view: ChecklistImageView!
    var isSet: Bool = false {
        didSet {
            if let view = view {
                view.gradientOverlay.isHidden = !isSet
            }
        }
    }

    let checklistItem: ChecklistItem
    weak var viewController: UIViewController?
    var currentFilename: String?

    var imageView: UIImageView {
        return view.imageView!
    }

    var itemFormat: ChecklistItem.Format {
        fatalError("Need to override this in the child class")
    }

    var placeholderImage: UIImage {
        fatalError("Need to override this in the child class")
    }

    init(checklistItem: ChecklistItem, viewController: UIViewController) {
        self.checklistItem = checklistItem
        self.viewController = viewController
    }

    func createView() -> UIView {

        view = ChecklistImageView.loadViewFromNib()
        view.imageHeadingView.title.text = checklistItem.item
        view?.imageHeadingView.isOptional = checklistItem._optional
        setupGradientOverlay()

        imageView.image = placeholderImage
        imageView.layer.borderColor = UIColor.AppColor.Grey.Line.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5.0
        customSetup()
        view.caption.text = L10n.Common.add
        view.caption.textColor = UIColor.AppColor.Grey.Line
        configureTap(imageView: imageView)
        configureClear(clearButton: view.clearButton)
        return view!
    }

    private func setupGradientOverlay() {

        let gradientOverlay = view.gradientOverlay
        let gradient = CAGradientLayer()

        gradient.frame = gradientOverlay!.bounds
        gradient.colors = [UIColor.AppColor.Black.Clear.cgColor, UIColor.AppColor.Black.Max60pc.cgColor]
        gradient.locations = [0.0, 1.0]
        gradientOverlay?.layer.mask = gradient
        gradientOverlay?.isHidden = true
        gradientOverlay?.applyCornerBottomRadius()
    }

    @objc func clearTapped(gesture _: UITapGestureRecognizer) {
        if let fileName = currentFilename {
            FileUtil.deleteFile(named: fileName)
        }
        currentFilename = nil
        imageView.image = placeholderImage
        imageView.contentMode = .scaleAspectFill
        view.gradientOverlay?.isHidden = true
        view.caption.text = L10n.Common.add
        view.caption.textColor = UIColor.AppColor.Grey.Line
        view.caption.shadowColor = UIColor.clear
        view.clearButton.isHidden = true
        view.clearImage.isHidden = true
    }

    /** use as a hook for implementing custom behavior during view creation */
    func customSetup() {}

    private func configureClear(clearButton _: UIButton) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearTapped(gesture:)))
        view.clearButton.isUserInteractionEnabled = true
        view.clearButton.addGestureRecognizer(tapGestureRecognizer)
    }

    private func configureTap(imageView: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(gesture:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func imageViewTapped(gesture _: UITapGestureRecognizer) {
        imageViewTapped()
    }

    func imageViewTapped() {
        fatalError("child class must override, until swift adds abstract methods")
    }

    func validate() -> Bool {
        guard currentFilename != nil else {
            if !checklistItem._optional! {
                view.imageHeadingView.displayErrorWithString(error: L10n.Checklist.Error.photo(checklistItem.item!))
                return false
            }
            return true
        }
        return true
    }

    func extractValue() throws -> (String, String)? {

        guard let savedFilename = currentFilename else {
            if !checklistItem._optional! {
                throw LocusSDKError.inputMissing(message: L10n.Checklist.Error.photo(checklistItem.item!))
            }
            return nil
        }
        return (checklistItem.key!, savedFilename)
    }

    func setValue(_ initialValue: String?) {
        if let value = initialValue, let filename = value.components(separatedBy: "/").last {
            imageView.contentMode = .scaleAspectFill
            if let retrievedData = FileUtil.getData(from: filename) {
                imageView.image = UIImage(data: retrievedData)
            } else {
                imageView.load(url: URL(string: value)!)
            }
            currentFilename = filename
            updateCaption()
        }
    }

    func format() -> ChecklistItem.Format {
        return self.itemFormat
    }

    func updateCaption() {

        isSet = true
        if let caption = view.caption {
            caption.text = L10n.Checklist.View.Photo.retake
            caption.textColor = UIColor.AppColor.White.Light
            caption.shadowColor = UIColor.AppColor.Black.Max
            (caption as UIView).ShadowOffset = CGSize(width: 0, height: 1)
            caption.shadowRadius = 1
        }
        view.clearImage.isHidden = false
        view.clearButton.isHidden = false
    }

    func saveAndPreviewImage(_ image: UIImage) {

        if let tipView = view.imageHeadingView.tipView {
            tipView.dismiss()
        }
        // takes barely 25ms, no need of background thread
        let scaledImage = ImageUtils.resize(image, toFit: 800)

        let filename = UUID().uuidString

        // delete the old file if a new one is taken
        if let currentFilename = currentFilename {
            FileUtil.deleteFile(named: currentFilename)
        }

        if let imageData = scaledImage.jpegData(compressionQuality: 0.7) {

            let success = FileUtil.saveData(data: imageData, to: filename)
            if success {
                imageView.contentMode = .scaleAspectFill
                let retrievedData = FileUtil.getData(from: filename)
                imageView.image = UIImage(data: retrievedData!)
                currentFilename = filename
                return
            }
        }
        Messages.showAlert(title: L10n.Common.error, message: L10n.Error.Image.save) {}
    }
}
