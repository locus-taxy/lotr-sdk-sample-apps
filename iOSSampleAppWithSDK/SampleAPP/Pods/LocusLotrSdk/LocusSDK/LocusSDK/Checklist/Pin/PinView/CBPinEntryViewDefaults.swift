//
//  CBPinEntryViewDefaults.swift
//  Pods
//
//  Created by Chris Byatt on 18/03/2017.
//
//
import Foundation
import UIKit

struct CBPinEntryViewDefaults {

    // Default number of fields
    static let length: Int = 4

    // Default spacing between fields
    static let spacing: CGFloat = 10

    // Default backgorund colour of pin entry field
    static let entryBackgroundColour = UIColor.white

    // Default border width
    static let entryBorderWidth: CGFloat = 1

    // Default border colour of fields before selection
    static let entryDefaultBorderColour = UIColor.clear

    // Default border colour of currently editing field
    static let entryBorderColour = UIColor(red: 69 / 255, green: 78 / 255, blue: 86 / 255, alpha: 1.0)

    // Default background colour of currently editing field
    static let entryEditingBackgroundColour = UIColor(red: 135 / 255, green: 154 / 255, blue: 168 / 255, alpha: 1.0)

    // Default border colour for error state
    static let entryErrorColour = UIColor.red

    // Default corner radius of entry fields
    static let entryCornerRadius: CGFloat = 3.0

    // Default text colour for the entry label
    static let entryTextColour = UIColor.darkText

    // Default font for entry fields
    static let entryFont = UIFont.systemFont(ofSize: 16)

    // Default bottom line thickness
    static let entryUnderlineThickness: CGFloat = 1

    // Default colour for the bottom line
    static let entryUnderlineColour = UIColor.darkText

    static let isSecure: Bool = false

    static let secureCharacter: String = "●"

    static let keyboardType: Int = 4
}
