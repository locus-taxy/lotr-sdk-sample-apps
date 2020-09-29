import Foundation

public enum UserVisitType: String, Codable {
    case startOfDay = "START_OF_DAY"
    case endOfDay = "END_OF_DAY"
    case shiftStart = "SHIFT_START"
    case shiftEnd = "SHIFT_END"
    case tourEnd = "TOUR_END"
    case _break = "BREAK"
    case other = "OTHER"
    case _none = "NONE"
}
