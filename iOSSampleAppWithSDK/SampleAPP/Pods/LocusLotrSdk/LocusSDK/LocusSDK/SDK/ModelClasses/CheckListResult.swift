import Foundation

/// Key value and type of checklist item
public struct ChecklistItemResult {
    let key: String
    let value: String
    let type: ChecklistItem.Format
}

/// On successful completion of Checklist this is returned
public struct ChecklistResult {

    /// Array of ChecklistListItemResult
    public let results: [ChecklistItemResult]

    /// Get the key values of checklist as a dictionary
    ///
    /// - Returns: key value dictionary
    public func getDictionary() -> [String: String] {
        var result: [String: String] = [:]
        for item in results {
            result[item.key] = item.value
        }
        return result
    }

    /// Get the key value of checklist as a dictionary after uploading all the files assocoated with the checklist to LOTR server
    ///
    /// - Parameter task: Task for which the checklist is being filled.This is required as the files are uploaded for that particular task
    /// - Returns: key value dictionary
    public func getDictionaryAfterUploadingFilesFor(task: Task) -> [String: String] {
        return uploadFiles(forTask: task)
    }

    private func uploadFiles(forTask task: Task) -> [String: String] {

        var modifiedChecklistValues: [String: String] = getDictionary()

        let filteredResults = results.filter { result -> Bool in
            result.type == .signature || result.type == .photo
        }

        for result in filteredResults {
            let currentFilename = result.value
            let fileUrl = uploadFile(named: currentFilename, forTask: task)
            modifiedChecklistValues[result.key] = fileUrl
        }

        return modifiedChecklistValues
    }

    private func uploadFile(named filename: String, forTask task: Task) -> String {

        if let data = FileUtil.getData(from: filename) {
            // this just writes it to the outstore db
            try! LocusSDK.uploadFile(task: task, fileName: filename, data: data)
        }
        return LocusSDKService.fileUploadUrl(task: task, filename: filename)
    }
}
