import Foundation

/** A request containing control event wrapper */

open class ControlEventPublishRequest: Codable {

    public var eventWrapper: ControlEventWrapper?
    /** Is message collapsible */
    public var collapse: Bool?
    /** Should message be registered */
    public var shouldRegister: Bool?

    public init(eventWrapper: ControlEventWrapper?, collapse: Bool?, shouldRegister: Bool?) {
        self.eventWrapper = eventWrapper
        self.collapse = collapse
        self.shouldRegister = shouldRegister
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(eventWrapper, forKey: "eventWrapper")
        try container.encodeIfPresent(collapse, forKey: "collapse")
        try container.encodeIfPresent(shouldRegister, forKey: "shouldRegister")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        eventWrapper = try container.decodeIfPresent(ControlEventWrapper.self, forKey: "eventWrapper")
        collapse = try container.decodeIfPresent(Bool.self, forKey: "collapse")
        shouldRegister = try container.decodeIfPresent(Bool.self, forKey: "shouldRegister")
    }
}
