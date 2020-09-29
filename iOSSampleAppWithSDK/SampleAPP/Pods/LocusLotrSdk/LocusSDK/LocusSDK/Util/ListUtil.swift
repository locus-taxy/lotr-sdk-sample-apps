import Foundation

class ListUtils {

    static func getElement<T>(at index: Int, in list: [T]) -> T? {
        if index < list.count {
            return list[index]
        }
        return nil
    }

    static func getFirstElement<T>(in list: [T]) -> T? {
        return getElement(at: 0, in: list)
    }

    static func split<T>(list: [T], by maxSize: Int) throws -> [[T]] {

        if maxSize < 1 {
            throw LocusSDKErrorInternal.illegalArgument(message: "Max Size should be at least 1")
        }

        let lists: [[T]] = stride(from: 0, to: list.count, by: maxSize).map { startIndex in
            Array(list[startIndex ..< min(startIndex + maxSize, list.endIndex)])
        }

        return lists
    }
}
