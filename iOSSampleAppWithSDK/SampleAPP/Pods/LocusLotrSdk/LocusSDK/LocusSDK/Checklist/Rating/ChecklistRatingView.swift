import Cosmos
import Foundation
import RxSwift
import UIKit

class ChecklistRatingView: UIView {

    @IBOutlet var headingView: UIView!
    var ratingHeadingView: ChecklistHeadingView!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var rating: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializeView()
    }

    func initializeView() {
        self.headingView.backgroundColor = UIColor.AppColor.Grey.Light
        ratingHeadingView = ChecklistHeadingView.loadViewFromNib()
        ratingHeadingView.addToSubview(view: headingView)
        ratingHeadingView.initializeView()

        self.rating.rating = 0.0
        self.rating.settings.starSize = 30.0
        self.rating.settings.totalStars = 5
        self.rating.settings.emptyBorderColor = LocusSDK.tintColour
        self.rating.settings.emptyBorderWidth = 1.0
        self.rating.settings.filledBorderColor = LocusSDK.tintColour
        self.rating.settings.filledBorderWidth = 1.0
        self.rating.settings.fillMode = .half
        self.rating.settings.emptyColor = UIColor.white
        self.rating.settings.filledColor = LocusSDK.tintColour

        self.rating.didTouchCosmos = { _ in
            if let tipview = self.ratingHeadingView.tipView {
                tipview.dismiss()
            }
        }
    }
}
