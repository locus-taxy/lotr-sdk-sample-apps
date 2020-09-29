import Foundation
import RxCocoa
import RxSwift
import UIKit

class ChecklistDateTimeView: UIView {

    var checklistHeadingView: ChecklistHeadingView!
    var dateTimrPresenter: ChecklistItemPresenter?

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var dateTimeHeadingView: UIView!
    @IBOutlet var dateTimeView: UIView!
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var clearDateButton: UIButton!
    @IBOutlet var clearDateImage: UIImageView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var clearTimeButton: UIButton!
    @IBOutlet var clearTimeImage: UIImageView!
    @IBOutlet var dateTimeStack: UIStackView!
    @IBOutlet var datePickerView: UIView!
    @IBOutlet var datePicker: UIDatePicker!

    var format: ChecklistItem.Format! {
        didSet {
            initializeView()
        }
    }

    var selectedDate: Date?
    var selectedTime: Date?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initializeView() {
        self.stackView.backgroundColor = UIColor.white
        dateTimeHeadingView.isHidden = false
        self.dateTimeHeadingView.backgroundColor = UIColor.AppColor.Grey.Light
        checklistHeadingView = ChecklistHeadingView.loadViewFromNib()
        checklistHeadingView.initializeView()
        checklistHeadingView.addToSubview(view: self.dateTimeHeadingView)
        datePickerView.isHidden = true

        dateLabel.updateStyle(styles: [])
        clearDateClicked(clearDateButton!)
        timeLabel.updateStyle(styles: [])
        clearTimeClicked(clearTimeButton!)
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        if format! == .date {
            timeView.isHidden = true
        }
        if format! == .time {
            dateView.isHidden = true
        }
        setInitialValue()
    }

    func setInitialValue() {
        if selectedDate != nil {
            updateDate(date: selectedDate!)
        }
        if selectedTime != nil {
            updateTime(date: selectedTime!)
        }
    }

    private func getFormattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.string(from: date)
    }

    private func getFormattedTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }

    private func updateDate(date: Date) {
        selectedDate = date
        selectedTime = date
        dateLabel.text = "\(L10n.Checklist.View.Datetime.date): \(getFormattedDate(date: selectedDate!))"
        clearDateButton.isHidden = false
        clearDateImage.isHidden = false
    }

    private func updateTime(date: Date) {
        selectedTime = date
        selectedDate = date
        timeLabel.text = "\(L10n.Checklist.View.Datetime.time): \(getFormattedTime(date: selectedTime!))"
        clearTimeButton.isHidden = false
        clearTimeImage.isHidden = false
    }

    @objc func datePickerChanged(picker: UIDatePicker) {
        if picker.datePickerMode == .date {
            updateDate(date: picker.date)
        }
        if picker.datePickerMode == .time {
            updateTime(date: picker.date)
        }
    }

    @IBAction func clearDateClicked(_: Any) {
        dateLabel.text = "\(L10n.Checklist.View.Datetime.selectDate):__ ____ ____"
        selectedDate = nil
        datePickerView.isHidden = true
        clearDateImage.isHidden = true
        clearDateButton.isHidden = true
    }

    @IBAction func dateButtonClicked(_: Any) {
        if let tipview = checklistHeadingView.tipView {
            tipview.dismiss()
        }
        if selectedDate == nil {
            updateDate(date: Date())
        }
        if datePicker.datePickerMode != .time {
            datePickerView.isHidden = !datePickerView.isHidden
        }
        datePicker.datePickerMode = .date
    }

    @IBAction func clearTimeClicked(_: Any) {
        timeLabel.text = "\(L10n.Checklist.View.Datetime.selectTime):__ : __ __"
        selectedTime = nil
        datePickerView.isHidden = true
        clearTimeImage.isHidden = true
        clearTimeButton.isHidden = true
    }

    @IBAction func timeButtonClicked(_: Any) {
        if let tipview = checklistHeadingView.tipView {
            tipview.dismiss()
        }
        if selectedTime == nil {
            updateTime(date: Date())
        }
        if datePicker.datePickerMode != .date {
            datePickerView.isHidden = !datePickerView.isHidden
        }
        datePicker.datePickerMode = .time
    }
}
