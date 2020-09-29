import Foundation
import UIKit

public class ImageUtils {

    private struct Constants {

        static let compressionQuality: Float = 0.7
    }

    public static func resize(_ image: UIImage, toFit maxDimension: Float) -> UIImage {

        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = maxDimension
        let maxWidth: Float = maxDimension
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                // adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                // adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(Constants.compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }

    public static func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint, size: CGSize) -> UIImage {

        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 10.0)
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key: Any]

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: image.size)
            let watermarkImage = renderer.image { ctx in
                // awesome drawing code
                let rectangle = CGRect(x: 0, y: 0, width: 1000, height: 1000)
                ctx.cgContext.setFillColor(UIColor.black.withAlphaComponent(0.5).cgColor)
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fill)
            }
            watermarkImage.draw(in: CGRect(origin: point, size: size))
        }

        let rect = CGRect(origin: CGPoint(x: point.x + 10, y: point.y + 10), size: CGSize(width: size.width - 10, height: size.height - 10))
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
