import Foundation

/** Visit Status Update request parameters */
public class VisitStatusUpdateParams {

    /** Id of task */
    let taskId: String

    /** Id of visit */
    let visitId: String

    /** Status of Visit */
    let visitStatus: VisitStatus.Status

    /** Checklist values for Visit Status update */
    let checklist: [String: String]?

    /// Visit Status Update request parameters
    ///
    /// - Parameters:
    ///   - taskId: Id of task
    ///   - visitId: Id of visit
    ///   - visitStatus: Status of Visit
    ///   - checklist: Checklist values for Visit Status update
    public init(taskId: String, visitId: String, visitStatus: VisitStatus.Status, checklist: [String: String]? = nil) {
        self.taskId = taskId
        self.visitId = visitId
        self.visitStatus = visitStatus
        self.checklist = checklist
    }
}
