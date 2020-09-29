import Foundation

/// Utility to save, get and delete files from the SDK
public class FileUtil {

    static let Tag: String = "\(String(describing: FileUtil.self))"

    static let fileManager = FileManager.default
    static let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

    /// Save File
    ///
    /// - Parameters:
    ///   - data: file data
    ///   - filename: name of file
    /// - Returns: if successfully saved or not
    public static func saveData(data: Data, to filename: String) -> Bool {

        let fileURL = documentDirectory.appendingPathComponent(filename)
        do {
            try data.write(to: fileURL)
            return true
        } catch {
            return false
        }
    }

    /// Get File data
    ///
    /// - Parameter filename: name of file
    /// - Returns: data if file present else returns nil
    public static func getData(from filename: String) -> Data? {
        let fileURL = documentDirectory.appendingPathComponent(filename)
        return try? Data(contentsOf: fileURL)
    }

    /// Delete File
    ///
    /// - Parameter filename: name of file
    public static func deleteFile(named filename: String) {
        let fileURL = documentDirectory.appendingPathComponent(filename)
        try? fileManager.removeItem(at: fileURL)
    }
}
