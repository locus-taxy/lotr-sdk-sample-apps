import Foundation

public struct SDKError: Codable {

    public var errorCode: Int?
    public var message: String?

    public init(errorCode: Int?, message: String?) {
        self.errorCode = errorCode
        self.message = message
    }
}

enum AuthErrorType {

    case general
    case passwordExpired

    var code: Int {
        switch self {
            case .general:
                return -1
            case .passwordExpired:
                return 1002
        }
    }

    static func getAuthErrorForCode(_ code: Int) -> (Notification.Name, AuthErrorType) {
        if code == AuthErrorType.passwordExpired.code {
            return (Notification.Name(rawValue: "com.locus.lotr.authError.passwordExpired"), AuthErrorType.passwordExpired)
        }
        return (Notification.Name(rawValue: "com.locus.lotr.authError"), AuthErrorType.general)
    }
}

enum ServerResponse<Value> {

    case success(Value)
    case authError(AuthErrorType, String?)
    case generalError(String?) // bad response (4xx, 5xx)

    var isSuccess: Bool {

        switch self {
            case .success:
                return true

            case .authError, .generalError:
                return false
        }
    }

    public var value: Value? {

        switch self {
            case let .success(value):
                return value

            case .authError, .generalError:
                return nil
        }
    }
}

// MARK: - CustomStringConvertible

extension ServerResponse: CustomStringConvertible {

    public var description: String {

        switch self {
            case .success:
                return "SUCCESS"

            case let .authError(_, message):
                return message ?? "AUTH_ERROR"

            case let .generalError(message):
                return message ?? "GENERAL_ERROR"
        }
    }

    public var errorMessage: String? {

        switch self {
            case .success:
                return nil

            case let .authError(_, message):
                return message

            case let .generalError(message):
                return message
        }
    }
}

// MARK: - Transform

extension ServerResponse {

    func map<TRANSFORMED>(transform: (Value) -> TRANSFORMED) -> ServerResponse<TRANSFORMED> {

        switch self {
            case let .success(value):
                return .success(transform(value))

            case let .authError(error, message):
                return .authError(error, message)

            case let .generalError(message):
                return .generalError(message)
        }
    }
}
