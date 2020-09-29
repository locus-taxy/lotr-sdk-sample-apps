import Foundation

open class ChecklistItem: Codable {

    public enum Format: String, Codable {
        case boolean = "BOOLEAN"
        case singleChoice = "SINGLE_CHOICE"
        case textField = "TEXT_FIELD"
        case pin = "PIN"
        case signature = "SIGNATURE"
        case photo = "PHOTO"
        case rating = "RATING"
        case url = "URL"
        case date = "DATE"
        case time = "TIME"
        case datetime = "DATETIME"
    }

    /** An identifier for this checklist item */
    public var key: String?
    /** String representation of the checklist item, to be displayed on the app */
    public var item: String?
    /**  Input format for the checklist item. Can be BOOLEAN, SINGLE_CHOICE, PIN, SIGNATURE, or PHOTO.  BOOLEAN field will be displayed as a checkbox, which delivery person can either check or uncheck.  SINGLE_CHOICE will be displayed as a group of radio buttons from which delivery person can choose one.  TEXT_FIELD will be displayed as a free form text box.  PIN will be a code sent to customer which will need to be entered into the app.  SIGNATURE will let the delivery person collect a signature from customer.  PHOTO will let delivery person click a picture of the item.  RATING will be displayed as stars for taking feedback.  URL will be displayed as a clickable url  DATE will be displayed as a date entry box  TIME will be displayed a time selection field  DATETIME will be displayed as a calendar entry box with time  */
    public var format: Format?
    /** Possible values for the item, depending on the format field. For a SINGLE_CHOICE, values will be strings to display. For PIN, it should be the actual code. For URL, it should be the URL to display and link to. For BOOLEAN, TEXT_FIELD, SIGNATURE and PHOTO, value isn&#39;t required. */
    public var possibleValues: [String]?
    public var allowedValues: [ChecklistPossibleValue]?
    public var _optional: Bool?
    /**  Any additional options to customize the behavior of the checklist item. For TEXT_FIELD, the key \&quot;inputType\&quot; can have values \&quot;DEFAULT\&quot;, \&quot;PHONE\&quot;, \&quot;NUMBER\&quot;, \&quot;DECIMAL\&quot;, \&quot;EMAIL_ADDRESS\&quot; or \&quot;PASSWORD\&quot; that determines the type of keyboard that appears. The key \&quot;regex\&quot; can be given a regular expression as the value that will be used to validate the TEXT_FIELD contents. The key \&quot;errorMessage\&quot; sets a custom error message if the text does not conform to the given regex.  */
    public var additionalOptions: [String: String]?

    public init(key: String?, item: String?, format: Format?, possibleValues: [String]?, allowedValues: [ChecklistPossibleValue]?, _optional: Bool?, additionalOptions: [String: String]?) {
        self.key = key
        self.item = item
        self.format = format
        self.possibleValues = possibleValues
        self.allowedValues = allowedValues
        self._optional = _optional
        self.additionalOptions = additionalOptions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(key, forKey: "key")
        try container.encodeIfPresent(item, forKey: "item")
        try container.encodeIfPresent(format, forKey: "format")
        try container.encodeIfPresent(possibleValues, forKey: "possibleValues")
        try container.encodeIfPresent(allowedValues, forKey: "allowedValues")
        try container.encodeIfPresent(_optional, forKey: "optional")
        try container.encodeIfPresent(additionalOptions, forKey: "additionalOptions")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        key = try container.decodeIfPresent(String.self, forKey: "key")
        item = try container.decodeIfPresent(String.self, forKey: "item")
        format = try container.decodeIfPresent(Format.self, forKey: "format")
        possibleValues = try container.decodeIfPresent([String].self, forKey: "possibleValues")
        allowedValues = try container.decodeIfPresent([ChecklistPossibleValue].self, forKey: "allowedValues")
        _optional = try container.decodeIfPresent(Bool.self, forKey: "optional")
        additionalOptions = try container.decodeIfPresent([String: String].self, forKey: "additionalOptions")
    }
}
