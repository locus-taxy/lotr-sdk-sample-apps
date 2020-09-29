import Foundation
import UIKit

/** A table view that expands itself fully(has an intrinsic size). Useful if embedding in a scrollview or a subclass of scrollview
 **/
class SelfSizedTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
