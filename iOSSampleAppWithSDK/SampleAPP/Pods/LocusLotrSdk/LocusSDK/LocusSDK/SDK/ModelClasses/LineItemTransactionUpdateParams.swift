import Foundation

/** Line Item Transaction Update request parameters */

public class LineItemTransactionUpdateParams {

    /** Id of task */
    let taskId: String
    /** Id of visit */
    let visitId: String
    /* Transaction status of a line items */
    let lineItems: [LineItemTransactionStatus]?

    /// Line Item Transaction Update request parameters
    ///
    /// - Parameters:
    ///   - taskId: Id of task
    ///   - visitId: Id of visit
    ///   - lineItems: Transaction status of a line items
    public init(taskId: String, visitId: String, lineItems: [LineItemTransactionStatus]? = nil) {
        self.taskId = taskId
        self.visitId = visitId
        self.lineItems = lineItems
    }
}
