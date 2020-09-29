import Foundation

/** A container for checklist settings */

open class ChecklistSetting: Codable {

    public enum ImageQuality: String, Codable {
        case low = "LOW"
        case medium = "MEDIUM"
        case high = "HIGH"
    }

    /** Quality of images sent as checklist item pod. LOW is ~0.5MP, MEDIUM is ~1.9MP, HIGH is ~4.3MP (MP &#x3D; MegaPixels) WARNING: Setting higher qualities will increase quantity of data transferred over the network  */
    public var imageQuality: ImageQuality?
    /** If true, let rider crop the POD when captured */
    public var enableCropping: Bool?

    public init(imageQuality: ImageQuality?, enableCropping: Bool?) {
        self.imageQuality = imageQuality
        self.enableCropping = enableCropping
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(imageQuality, forKey: "imageQuality")
        try container.encodeIfPresent(enableCropping, forKey: "enableCropping")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        imageQuality = try container.decodeIfPresent(ImageQuality.self, forKey: "imageQuality")
        enableCropping = try container.decodeIfPresent(Bool.self, forKey: "enableCropping")
    }
}
