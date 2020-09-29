import Foundation

protocol LocusSDKProtocol {

    func initialize(params: AuthParams?, delegate: LocusSDKDelegate, successBlock: @escaping successBlock, failureBlock: @escaping failureBlock)

    func startTracking() throws

    func stopTracking() throws

    func getLocusSDKStatus() -> LocusSDKStatus

    func getLastKnownLocation() -> Location?

    func getLastSyncedLocation() -> Location?

    func updateTaskStatus(taskStatusUpdateParams: TaskStatusUpdateParams) throws

    func updateVisitStatus(visitStatusUpdateParams: VisitStatusUpdateParams) throws

    func updateTourStatus(tourStatusUpdateParams: TourStatusUpdateParams) throws

    func updateLineItemTransaction(lineItemTransactionUpdateParams: LineItemTransactionUpdateParams) throws

    func uploadFile(task: Task, fileName: String, data: Data) throws

    func sync(forceTransmit: Bool, successBlock: @escaping successBlock, failureBlock: @escaping failureBlock) throws

    func displayChecklistView(checklist: Checklist, displayConfig: LocusSDKChecklistDisplayConfig, initialValues: [String: String]?, successBlock: @escaping (ChecklistResult) -> Void) throws
}
