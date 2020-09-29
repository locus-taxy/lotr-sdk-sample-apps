
import AVFoundation
import Foundation
import UIKit

protocol ScannerDelegate: class {

    func scannerDidScanWith(data scanData: String)
    func scannerDidCancel()
}

@available(iOS 10.0, *)
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var statusBarView: UIView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var captureView: UIView!
    @IBOutlet var redline: UIView!

    var feedbackGenerator = UINotificationFeedbackGenerator()
    weak var scannerDelegate: ScannerDelegate?

    var captureDevice: AVCaptureDevice?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureSession: AVCaptureSession?

    var scanData: String?
    var scanFrame: CGRect?

    let codeFrame: UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()

    func initializeView() {
        statusBarView.backgroundColor = LocusSDK.tintColour
        view.backgroundColor = .white
        if let navigationBar = navigationBar {
            UIUtil.configureNavigationBar(navigationBar: navigationBar)
        }
        navigationBar.topItem?.title = L10n.Scanner.View.title
        navigationBar.topItem?.leftBarButtonItem = nil
        navigationBar.topItem?.rightBarButtonItem = cancelButton
        doneButton.title = L10n.Common.done
        cancelButton.title = L10n.Common.cancel

        doneButton.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeView()

        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {

            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)

                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)

                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)

                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13, .ean8, .code39] // AVMetadataObject.ObjectType

                captureSession.startRunning()

                self.setVideoPreviewLayer()

            } catch {
                print("Error Device Input")
            }
        }
    }

    private func setVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        captureView.layer.addSublayer(videoPreviewLayer!)
    }

    override func viewDidLayoutSubviews() {
        self.configureVideoOrientation()
    }

    private func configureVideoOrientation() {
        if let previewLayer = self.videoPreviewLayer,
            let connection = previewLayer.connection
        {
            let orientation = UIDevice.current.orientation

            if connection.isVideoOrientationSupported,
                let videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue)
            {
                previewLayer.frame = self.view.bounds
                connection.videoOrientation = videoOrientation
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func metadataOutput(_: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from _: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            // print("No Input Detected")
            codeFrame.frame = CGRect.zero
            return
        }

        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        guard let stringCodeValue = metadataObject.stringValue else { return }
        self.scanData = stringCodeValue
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        self.scanFrame = barcodeObject.bounds
        codeFrame.frame = self.scanFrame!
        self.captureView.addSubview(codeFrame)
        self.doneButton.isEnabled = true
        feedbackGenerator.notificationOccurred(.success)

        // Stop capturing and hence stop executing metadataOutput function over and over again
        captureSession?.stopRunning()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if let data = self.scanData {
                self.dismiss(animated: true) {
                    self.scannerDelegate?.scannerDidScanWith(data: data)
                }
            }
        }
    }

    @IBAction func cancelClicked(_: Any) {
        self.scannerDelegate?.scannerDidCancel()
        self.dismiss(animated: true) {}
    }

    @IBAction func doneClicked(_: Any) {
        if let data = scanData {
            self.scannerDelegate?.scannerDidScanWith(data: data)
            self.dismiss(animated: true) {}
        }
    }
}
