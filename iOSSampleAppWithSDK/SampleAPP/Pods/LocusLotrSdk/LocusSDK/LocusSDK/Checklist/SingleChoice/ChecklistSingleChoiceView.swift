import UIKit

class ChecklistSingleChoiceView: UIView {

    @IBOutlet var headingView: UIView!
    var singleChoiceHeadingView: ChecklistHeadingView!
    var singleChoicePresenter: ChecklistItemPresenter?
    @IBOutlet private var tableView: UITableView!

    var selectedRow: Int?
    weak var delegate: ChecklistSingleChoiceViewDelegate?

    override func awakeFromNib() {

        super.awakeFromNib()
        initializeView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }

    func initializeView() {
        headingView.backgroundColor = UIColor.AppColor.Grey.Light
        singleChoiceHeadingView = ChecklistHeadingView.loadViewFromNib()
        singleChoiceHeadingView.addToSubview(view: headingView)
        singleChoiceHeadingView.initializeView()
    }

    func refresh() {
        tableView.reloadData()
    }
}

protocol ChecklistSingleChoiceViewDelegate: class {

    func titleForRowAt(index: Int) -> String

    func numberOfRows() -> Int
}

extension ChecklistSingleChoiceView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // warning - cells are not re-used here, options are expected to be limited in quantity
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.backgroundColor = UIColor.white
        cell.textLabel?.updateStyle(styles: [fontSizes.medium])
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.setHTMLText(text: (delegate?.titleForRowAt(index: indexPath.row))!)
        cell.accessoryType = row == selectedRow ? .checkmark : .none

        return cell
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return delegate?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        _ = singleChoicePresenter?.validate()
    }
}
