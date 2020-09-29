import UIKit

class ChecklistImageView: UIView {

    @IBOutlet var headingView: UIView!
    var imageHeadingView: ChecklistHeadingView!
    @IBOutlet var caption: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gradientOverlay: UIView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var clearImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializeView()
    }

    func initializeView() {
        headingView.backgroundColor = UIColor.AppColor.Grey.Light
        imageHeadingView = ChecklistHeadingView.loadViewFromNib()
        imageHeadingView.addToSubview(view: headingView)
        imageHeadingView.initializeView()
        clearButton.backgroundColor = UIColor.white
        clearButton.cornerRadius = 10.0
        clearButton.applyShadow()
        clearButton.isHidden = true
        clearImage.isHidden = true
    }
}
