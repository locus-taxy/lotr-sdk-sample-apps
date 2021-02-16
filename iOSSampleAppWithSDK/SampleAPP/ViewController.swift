//
//  ViewController.swift
//  SampleAPP
//
//  Created by Karthik M N on 28/09/20.
//
import UIKit
import LocusFramework

extension Task {

    static func from(clientId: String, taskId: String) -> Task {

        return Task(clientId: clientId, taskId: taskId, status: nil, sourceOrderId: nil, scanId: nil, orderDetail: nil, assignedUser: nil, creationTime: nil, completionTime: nil, checklists: nil, statusUpdates: nil, customFields: nil, taskGraph: nil, carrierTeams: nil, taskAppConfig: nil)
    }
}

class ViewController: UIViewController {

    var currentFilename: String?
    @IBOutlet var console: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        console.isUserInteractionEnabled = false
    }

    @IBAction func initializeClicked(_: Any) {

        let alert = UIAlertController(title: "Initialize", message: "Enter Client User Id and Password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.tag = 1
            textField.placeholder = "Client ID"
            textField.text = ""
        }
        alert.addTextField { textField in
            textField.tag = 2
            textField.placeholder = "User ID"
            textField.text = ""
        }
        alert.addTextField { textField in
            textField.tag = 3
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in

            let client = alert.textFields?.first { $0.tag == 1 }?.text ?? ""
            let userId = alert.textFields?.first { $0.tag == 2 }?.text ?? ""
            let password = alert.textFields?.first { $0.tag == 3 }?.text ?? ""
            let param = AuthParams.forUser(clientId: client, userId: userId, password: password)
            LocusSDK.initialize(params: param, delegate: self, successBlock: {
                self.consolePrint("initializeSuccess")
            }, failureBlock: { error in
                self.consolePrint(error.message)
            })

        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in

        }))

        self.present(alert, animated: true) {}
    }

    @IBAction func reinitializeClicked(_: Any) {

        LocusSDK.reinitialize(delegate: self, successBlock: {
            self.consolePrint("reinitializeSuccess")
        }, failureBlock: { error in
            self.consolePrint(error.message)
        })
    }

    @IBAction func startTracking(_: Any) {

        LocusSDK.startTracking(successBlock: {}) { error in
            self.consolePrint("Start tracking error - \(LocusSDKError.error(error).message)")
        }
    }

    @IBAction func stopTracking(_: Any) {

        LocusSDK.stopTracking(successBlock: {}) { error in
            self.consolePrint("Stop tracking error - \(LocusSDKError.error(error).message)")
        }
    }

    @IBAction func triggerSync(_: Any) {
        LocusSDK.sync(forceTransmit: true, successBlock: {
            self.consolePrint("sync success")
        }, failureBlock: { error in
            self.consolePrint(error.message)
        })
    }

    @IBAction func reloadConfigsClicked(_: Any) {
        LocusSDK.updateAppConfig(successBlock: {
            self.consolePrint("update success")
        }) { error in
            self.consolePrint(error.message)
        }
    }

    @IBAction func imageUpload(_: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func logout(_: Any) {
        LocusSDK.logout(forceLogout: false, successBlock: {
            self.consolePrint("Logout success")
        }) { error in
            self.consolePrint("Logout failure - \(error.message)")
        }
    }

    @IBAction func forceLogout(_: Any) {
        LocusSDK.logout(forceLogout: true, successBlock: {
            self.consolePrint("Logout success")
        }) { error in
            self.consolePrint("Logout failure - \(error.message)")
        }
    }

    @IBAction func displayChecklist(_: Any) {
        let checlistitems: [ChecklistItem] = [
            ChecklistItem(key: "cancellation-reason", item: "Select a reason", format: ChecklistItem.Format(rawValue: "SINGLE_CHOICE"), possibleValues: ["Customer not available", "Quality issue", "Cash unavailable", "Late delivery", "Partial order delivered"], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "signature-1", item: "Customer signature", format: ChecklistItem.Format(rawValue: "SIGNATURE"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "bool", item: "bill", format: ChecklistItem.Format(rawValue: "BOOLEAN"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "photo", item: "Item", format: ChecklistItem.Format(rawValue: "PHOTO"), possibleValues: [], allowedValues: [], _optional: true, additionalOptions: [:]),
            ChecklistItem(key: "url", item: "Terms and condition", format: ChecklistItem.Format(rawValue: "URL"), possibleValues: ["https://locus.sh/privacy-policy/"], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "text", item: "comments", format: ChecklistItem.Format(rawValue: "TEXT_FIELD"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "pin", item: "Order Pin", format: ChecklistItem.Format(rawValue: "PIN"), possibleValues: ["1234"], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "rating", item: "Drop rating", format: ChecklistItem.Format(rawValue: "RATING"), possibleValues: ["5"], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "date", item: "Drop Date", format: ChecklistItem.Format(rawValue: "DATE"), possibleValues: [], allowedValues: [], _optional: true, additionalOptions: [:]),
            ChecklistItem(key: "time", item: "Drop Time", format: ChecklistItem.Format(rawValue: "TIME"), possibleValues: [], allowedValues: [], _optional: true, additionalOptions: [:]),
            ChecklistItem(key: "datetime", item: "Drop Date and Time", format: ChecklistItem.Format(rawValue: "DATETIME"), possibleValues: [], allowedValues: [], _optional: true, additionalOptions: [:]),
        ]
        let checklist = Checklist(status: "Completed", items: checlistitems)
        LocusSDK.tintColour = UIColor.red
        let display = LocusSDKChecklistDisplayConfig(title: "Checklist", subtitle: "enter details and click submit", buttonTitle: "Submit", attributedTitle: NSAttributedString(string: "CHECKLIST"), attributedSubtitle: nil, type: .fullScreen)
        LocusSDK.displayChecklistView(checklist: checklist, displayConfig: display, initialValues: ["datetime": "2021-08-20T13:15:15", "date": "2020-08-25", "time": "13:30:23"], successBlock: { result in self.consolePrint(result.getDictionaryAfterUploadingFilesFor(task: Task.from(clientId: "test", taskId: "2020-08-19-karthikmn_11")).description) }) { error in
            self.consolePrint(error.message)
        }
    }

    func consolePrint(_ message: String) {
        DispatchQueue.main.async {
            self.console.text = message
        }
    }
}

extension ViewController: LocusSDKDelegate {
    func isOfflineStatusChanged(isOffline: Bool) {
        consolePrint("isOfflineStatusChanged-----\(isOffline)----")
    }

    func onLocationUpdated(location: Location) {
        consolePrint("onLocationUpdated---\(location.lat ?? 0.0)\(location.lng ?? 0.0)----")
    }

    func onLocationError(error: LocusSDKError) {
        consolePrint("onLocationError---\(error.message)----")
    }

    func onLocationUploaded(location: Location) {
        consolePrint("onLocationUploaded---\(location.lat ?? 0.0)\(location.lng ?? 0.0)----")
    }

    func locusSDKStatusChanged(status: LocusSDKStatus) {
        consolePrint("locusSDKStatusChanged---\(status)----")
    }

    func logEvent(tag: String, message: String, logLevel: LocusSDKLogLevel) {
        consolePrint("logEvent--\(tag)---\(message)---\(logLevel.rawValue)")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.saveAndPreviewImage(image)
        picker.dismiss(animated: true, completion: nil)
    }

    func saveAndPreviewImage(_ image: UIImage) {

        let filename = UUID().uuidString

        let imageCompressed = ImageUtils.resize(image, toFit: 800)
        // delete the old file if a new one is taken
        if let currentFilename = currentFilename {
            FileUtil.deleteFile(named: currentFilename)
        }

        if let imageData = imageCompressed.jpegData(compressionQuality: 0.7) {

            let success = FileUtil.saveData(data: imageData, to: filename)
            if success {
                currentFilename = filename
                do {
                    try LocusSDK.uploadFile(task: Task.from(clientId: "", taskId: ""), fileName: currentFilename!, data: imageData)
                } catch {
                    self.consolePrint("Error - \(LocusSDKError.error(error).message)")
                }
                return
            }
        }
    }
}


