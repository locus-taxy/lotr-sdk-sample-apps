import UIKit

class ChecklistBooleanView: UIView {

    @IBOutlet var title: UILabel!
    @IBOutlet var userInput: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializeView()
    }

    func initializeView() {
        title.updateStyle(styles: [])
        userInput.onTintColor = LocusSDK.tintColour
        userInput.isOn = false
    }
}
