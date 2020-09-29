import Foundation
import RxSwift
import UIKit

/// block of code that get executed on success
public typealias successBlock = () -> Void

/// block of code that get executed on failure and will need to handle the LocusSDKError
public typealias failureBlock = (LocusSDKError) -> Void

/// Public APIs which can be user for location tracking
public class LocusSDK {

    /// Initialize the SDK
    ///
    /// - Parameters:
    ///   - params: Authentication Param object with all the auth information like clientId,UserId,Password and isClientAuth
    ///   - delegate: implementaion of {@link LocusSDKDelegate}
    ///   - successBlock: block is called on initialization success
    ///   - failureBlock: block is called when an error occurs during initalization
    ///
    public static func initialize(params: AuthParams, delegate: LocusSDKDelegate, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        LocusSDKImplementation.shared.initialize(params: params, delegate: delegate, successBlock: successBlock, failureBlock: failureBlock)
    }

    /// Reinitialize the SDK
    ///
    /// This can be used at the launch of application to reinitialize the location tracking provided the initialize has already been done.
    ///
    /// - Parameters:
    ///   - delegate: implementaion of {@link LocusSDKDelegate}
    ///   - successBlock: block is called on reinitialization success
    ///   - failureBlock: block is called when an error occurs during reinitialization
    ///
    public static func reinitialize(delegate: LocusSDKDelegate, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        LocusSDKImplementation.shared.initialize(params: nil, delegate: delegate, successBlock: successBlock, failureBlock: failureBlock)
    }

    /// UpdateAuthParams
    ///
    /// This can be used to update the authparams when ever there is a change in the AuthParams(i.e the password updated or username updated)
    ///
    /// - Parameters:
    ///   - param: Updated AuthParam
    ///   - successBlock: block is called on updatation success
    ///   - failureBlock: block is called when an error occurs during updation
    public static func updateAuthParam(param: AuthParams, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        LocusSDKImplementation.shared.updateAuthParams(params: param, successBlock: successBlock, failureBlock: failureBlock)
    }

    /// UpdateAppConfig
    ///
    /// This can be used to update the AppConfig when ever there is a change in the Client AppConfig
    ///
    /// - Parameters:
    ///   - param: AuthParam
    ///   - successBlock: block is called on updatation success
    ///   - failureBlock: block is called when an error occurs during updation
    public static func updateAppConfig(successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        LocusSDKImplementation.shared.updateAppConfig(successBlock: successBlock, failureBlock: failureBlock)
    }

    /// Request Authorization
    ///
    /// Request the location manger to show the permission dialog if required.
    ///
    public static func requestAuthorization() {
        LocusSDKImplementation.shared.requestAuthorization()
    }

    /// Logout
    ///
    /// Force logout will cause the SDK to clear all the stored data and may result in loss of data
    ///
    /// - Parameters:
    ///   - forceLogout: boolean to indicate should force logout or not
    ///   - successBlock: block is called on logout success
    ///   - failureBlock: block is called on logout failure
    public static func logout(forceLogout: Bool, successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        do {
            try LocusSDKImplementation.shared.logout(forceLogout: forceLogout, successBlock: successBlock, failureBlock: failureBlock)
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    /// Is Tracking
    ///
    /// Returns if the the sdk is tracking
    ///
    public static func isTracking() -> Bool {
        return LocusSDKImplementation.shared.isTracking()
    }

    /// Start tracking
    ///
    /// On calling this function the sdk will start tracking the locations and updates it to the server
    ///   - successBlock: block is called on success
    ///   - failureBlock: block is called on failure
    public static func startTracking(successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        do {
            try LocusSDKImplementation.shared.startTracking()
            successBlock()
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    /// Stop tracking
    ///
    /// On calling this function the sdk will stop tracking
    ///   - successBlock: block is called on success
    ///   - failureBlock: block is called on failure
    public static func stopTracking(successBlock: @escaping () -> Void, failureBlock: @escaping (_ error: LocusSDKError) -> Void) {
        do {
            try LocusSDKImplementation.shared.stopTracking()
            successBlock()
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    /// getLocusSDKStatus
    ///
    /// - Returns: status of the sdk
    public static func getLocusSDKStatus() -> LocusSDKStatus {
        return LocusSDKImplementation.shared.getLocusSDKStatus()
    }

    /// getLastKnownLocation
    ///
    /// - Returns: the last known location that was given by location services
    public static func getLastKnownLocation() -> Location? {
        return LocusSDKImplementation.shared.getLastKnownLocation()
    }

    /// getLastSyncedLocation
    ///
    /// - Returns: the last location that was uploaded to the locus server
    public static func getLastSyncedLocation() -> Location? {
        return LocusSDKImplementation.shared.getLastSyncedLocation()
    }

    /// Sync
    ///
    /// Upload data to the server
    /// - Parameters:
    ///   - forceTransmit: force fully upload all the data in local store
    ///   - successBlock: called after successful completion of sync
    ///   - failureBlock: called after failure of sync
    public static func sync(forceTransmit: Bool, successBlock: @escaping successBlock, failureBlock: @escaping failureBlock) {
        do {
            try LocusSDKImplementation.shared.sync(forceTransmit: forceTransmit, successBlock: successBlock, failureBlock: failureBlock)
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    /// Update Task Status
    ///
    /// This can be used to update the status of the task in locus server
    ///
    /// - Parameters:
    ///   - taskStatusUpdateParams: TaskStatusUpdateParams object
    /// - Throws: LocusSDKError on error/failure
    public static func updateTaskStatus(taskStatusUpdateParams: TaskStatusUpdateParams) throws {

        try LocusSDKImplementation.shared.updateTaskStatus(taskStatusUpdateParams: taskStatusUpdateParams)
    }

    /// Update Tour Status
    ///
    /// This can be used to update the visit status of a visit
    ///
    /// - Parameters:
    ///   - visitStatusUpdateParams: VisitStatusUpdateParams object
    /// - Throws: LocusSDKError on error/failure
    public static func updateVisitStatus(visitStatusUpdateParams: VisitStatusUpdateParams) throws {

        try LocusSDKImplementation.shared.updateVisitStatus(visitStatusUpdateParams: visitStatusUpdateParams)
    }

    public static func updateTourStatus(tourStatusUpdateParams: TourStatusUpdateParams) throws {

        try LocusSDKImplementation.shared.updateTourStatus(tourStatusUpdateParams: tourStatusUpdateParams)
    }

    /// Update LineItem Transaction
    ///
    /// - Parameters:
    ///   - lineItemTransactionUpdateParams: LineItemTransactionUpdateParams object
    /// - Throws: LocusSDKError on error/failure
    public static func updateLineItemTransaction(lineItemTransactionUpdateParams: LineItemTransactionUpdateParams) throws {

        try LocusSDKImplementation.shared.updateLineItemTransaction(lineItemTransactionUpdateParams: lineItemTransactionUpdateParams)
    }

    /// Upload File
    ///
    /// To upload the file call FileUtil.saveData(data:,fileName:) before calling this function.
    ///
    /// - Parameters:
    ///   - task: task for which the image is being uploaded
    ///   - fileName: name of the file
    ///   - data: file data
    /// - Throws: LocusSDKError on error/failure
    public static func uploadFile(task: Task, fileName: String, data: Data) throws {
        try LocusSDKImplementation.shared.uploadFile(task: task, fileName: fileName, data: data)
    }

    /// The Tint Color of the various components of the Checklist likes like button,switch,navigation bar will be set to this value
    public static var tintColour: UIColor {
        get {
            return Provider.getDataManager().tintColour!
        }
        set {
            Provider.getDataManager().tintColour = newValue
        }
    }

    /// Display the checklist
    ///
    /// - Parameters:
    ///  - checklist: list of checklisk items to be shown
    ///  - displayConfig: All the configuraitons and the values needed for display
    ///  - initialValues: initial values for the checklist items.
    ///  - successBlock: Block that will be executed on succesfull complition of checklist
    ///  - failureBlock: Block that will be executed on failure (display is called without initialize)
    public static func displayChecklistView(checklist: Checklist, displayConfig: LocusSDKChecklistDisplayConfig? = nil, initialValues: [String: String]? = nil, successBlock: @escaping (ChecklistResult) -> Void, failureBlock: @escaping failureBlock = { _ in }) {
        do {
            let display = displayConfig == nil ? LocusSDKChecklistDisplayConfig.defaultConfig() : displayConfig
            try LocusSDKImplementation.shared.displayChecklistView(checklist: checklist, displayConfig: display!, initialValues: initialValues, successBlock: successBlock)
        } catch {
            failureBlock(LocusSDKError.error(error))
        }
    }

    /// Get the count of all the items that are yet to be synced with the server
    ///
    /// - Returns: count of items
    public static func getAllDaoCount() -> Int {
        return Provider.getOutStoreDataManager().getAllDaoCount()
    }

    /// getAllDaoCountWith
    ///
    /// Gets the count all the entried in the SDK with the clientID and taskID that are present in the queue and yet to be synced with the server
    ///
    /// - Parameters:
    ///   - clientId: clientId String
    ///   - taskId: taskId string
    /// - Returns: the count of the items
    public static func getAllDaoCountWith(clientId: String, taskId: String) -> Int {
        return Provider.getOutStoreDataManager().get(clientId: clientId, taskId: taskId).count
    }

    /// Clear
    ///
    /// Calling this will delete and clear all the stored data in the SDK
    public static func clear() {
        Provider.getDataManager().clearStoredData()
        Provider.getOutStoreDataManager().deleteAll()
    }
}
