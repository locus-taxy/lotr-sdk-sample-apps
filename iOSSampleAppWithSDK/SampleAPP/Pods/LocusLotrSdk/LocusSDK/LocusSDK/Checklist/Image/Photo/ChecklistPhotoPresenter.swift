import CropViewController
import UIKit

class ChecklistPhotoPresenter: ChecklistImagePresenter {

    private let imagePicker = UIImagePickerController()

    override var placeholderImage: UIImage {
        return ResourceHelper.checklistPhoto
    }

    override var itemFormat: ChecklistItem.Format {
        return ChecklistItem.Format.photo
    }

    override func customSetup() {
        imagePicker.delegate = self
    }

    override func imageViewTapped() {

        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }

        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.allowsEditing = false

        CameraPermission.checkCameraPermission(onSuccess: {
            self.viewController?.present(self.imagePicker, animated: true, completion: nil)
        }) {}
    }
}

extension ChecklistPhotoPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {

        guard let takenImage = info[.originalImage] as? UIImage else {
            return
        }

        if Provider.getDataManager().clientAppConfig?.checklistSetting?.enableCropping ?? false {
            picker.dismiss(animated: false) {
                let cropViewController = CropViewController(image: takenImage)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                UIApplication.topViewController()?.present(cropViewController, animated: false, completion: nil)
            }
            return
        }

        saveAndPreviewImage(takenImage)
        updateCaption()
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ChecklistPhotoPresenter: CropViewControllerDelegate {
    func cropViewController(_ cropView: CropViewController, didCropToImage takenImage: UIImage, withRect _: CGRect, angle _: Int) {
        cropView.dismiss(animated: true) {
            self.saveAndPreviewImage(takenImage)
            self.updateCaption()
        }
    }

    func cropViewController(_ cropView: CropViewController, didFinishCancelled _: Bool) {
        cropView.dismiss(animated: true) {}
    }
}
