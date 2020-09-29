import Foundation
import RxCocoa
import RxSwift
import UIKit

class CheckBoxButton: UIButton {
    // Images
    let checkedImage = ResourceHelper.checkBoxSelected
    let uncheckedImage = ResourceHelper.checkBoxUnSelected

    var isCheckedVariable = BehaviorRelay(value: false)

    var isChecked = false {
        didSet {
            isCheckedVariable.accept(isChecked)
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    var buttonClicked: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        setup()
    }

    func setup() {
        addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            if buttonClicked != nil {
                self.buttonClicked!()
            }
        }
    }
}
