import Foundation

/** Task Status Update request parameters */
public class TaskStatusUpdateParams {

    /** Id of task */
    let taskId: String

    /** Status of task */
    let taskStatus: TaskStatus.Status

    /** Checklist values for task update */
    let checklist: [String: String]?

    /// Task Status Update request parameters
    ///
    /// - Parameters:
    ///   - taskId: Id of task
    ///   - taskStatus: Status of task
    ///   - checklist: Checklist values for task update
    public init(taskId: String, taskStatus: TaskStatus.Status, checklist: [String: String]? = nil) {
        self.taskId = taskId
        self.taskStatus = taskStatus
        self.checklist = checklist
    }
}
