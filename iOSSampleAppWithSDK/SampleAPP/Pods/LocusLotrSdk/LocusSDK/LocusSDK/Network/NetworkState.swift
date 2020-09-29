import Foundation

public struct NetworkState: Codable {

    var firstFailureTime: Int64?
    var lastSuccessTime: Int64 = 0
    var currentFailCount: Int = 0
    var failureNotificationShown: Bool = false

    mutating func incrementFailCount() {
        currentFailCount += 1
    }

    mutating func resetFailCount() {
        currentFailCount = 0
    }
}

class NetworkStateManager {

    class func recordNetworkSuccess() {
        var state = NetworkState()
        state.firstFailureTime = nil
        state.lastSuccessTime = Date().milliSecondsSinceEpoch
        state.resetFailCount()
        state.failureNotificationShown = false
        Provider.getDataManager().networkState = state
    }

    class func recordNetworkFailure() {
        let dataManager = Provider.getDataManager()
        var state = dataManager.networkState
        if state == nil {
            state = NetworkState()
        }
        if state?.firstFailureTime == nil {
            state?.firstFailureTime = Date().milliSecondsSinceEpoch
        }

        state?.incrementFailCount()

        dataManager.networkState = state
    }

    class var lastSuccessTime: Int64 {
        let state = Provider.getDataManager().networkState
        return state?.lastSuccessTime ?? 0
    }
}
