import Foundation

class PathDataExtractor {

    private static let ClientIdPattern = ".*/client/([a-zA-Z0-9_-]+)/.*"
    private static let TaskIdPattern = ".*/task/([a-zA-Z0-9_-]+)/.*"
    private static let UserIdPattern = ".*/user/([a-zA-Z0-9_-]+)/.*"
    private static let FilenamePattern = ".*/file/([a-zA-Z0-9_-]+)"

    static func getClientId(in path: String) -> String? {
        return getString(using: ClientIdPattern, from: path)
    }

    static func getUserId(in path: String) -> String? {
        return getString(using: UserIdPattern, from: path)
    }

    static func getTaskId(in path: String) -> String? {
        return getString(using: TaskIdPattern, from: path)
    }

    static func getFilename(in path: String) -> String? {
        return getString(using: FilenamePattern, from: path)
    }

    static func isLocationUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/user/([a-zA-Z0-9_-]+)/location", from: path)
    }

    static func isTaskStatusUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/task/([a-zA-Z0-9_-]+)/status", from: path)
    }

    static func isVisitStatusUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/task/([a-zA-Z0-9_-]+)/visit/([a-zA-Z0-9_-]+)/status", from: path)
    }

    static func isUserVisitStatusUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/user/([a-zA-Z0-9_-]+)/visit/([a-zA-Z0-9_-]+)/status", from: path)
    }

    static func isTourVisitStatusUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/tour/([a-zA-Z0-9_-]+)/visit/([a-zA-Z0-9_-]+)/status", from: path)
    }

    static func isLineItemStatusUpdate(in path: String) -> Bool {
        return hasMatch(using: ".*/client/([a-zA-Z0-9_-]+)/task/([a-zA-Z0-9_-]+)/visit/([a-zA-Z0-9_-]+)/lineitemtransaction", from: path)
    }

    private static func hasMatch(using regex: String, from path: String) -> Bool {
        return path.matchingStrings(regex: regex).first != nil
    }

    private static func getString(using regex: String, from path: String) -> String? {

        guard let matches = path.matchingStrings(regex: regex).first, matches.count > 1 else {
            return nil
        }
        return matches[1]
    }
}
