import Foundation
import RxSwift

protocol WebService {

    func login(authParams: AuthParams) -> Observable<SdkInitializationResponse?>

    func bulk(clientId: String, userId: String, bulkUpdates: BulkUpdates) -> Observable<Bool>

    func updateLocation(clientId: String, userId: String, location: Location) -> Observable<Bool>

    func uploadFile(clientId: String, taskId: String, filename: String, data: Data) -> Observable<FileUploadResponse?>

    func updateTaskStatus(clientId: String, taskId: String, taskStatus: TaskStatus.Status, checklist: [String: String]?) -> Observable<Task?>

    func updateVisitStatus(clientId: String, taskId: String, visitId: String, visitStatus: VisitStatus.Status, checklist: [String: String]?) -> Observable<Task?>

    func updateTourStatus(clientId: String, tourId: String, visitId: String, visitStatus: VisitStatus.Status, checklist: [String: String]?) -> Observable<Task?>

    func updateLineItemTransaction(clientId: String, taskId: String, visitId: String, lineItems: [LineItemTransactionStatus]?) -> Observable<Task?>
}
