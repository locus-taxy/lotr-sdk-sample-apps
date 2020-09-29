import Foundation
import Moya

class JsonSerializer {

    static let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        return jsonEncoder
    }()

    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return jsonDecoder
    }()

    class func serialize<T: Encodable>(_ object: T) -> String? {
        do {
            let jsonData = try jsonEncoder.encode(object)
            return String(data: jsonData, encoding: .utf8)
        } catch {}
        return nil
    }

    class func deserialize<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            let object = try jsonDecoder.decode(type, from: data)
            return object
        } catch {
            if data == Moya.Data() {
                // ignore
                return nil
            }
        }
        return nil
    }

    class func deserialize<T: Decodable>(string: String, type: T.Type) -> T? {
        do {
            if let jsonData = string.data(using: .utf8) {
                let object = try jsonDecoder.decode(type, from: jsonData)
                return object
            }
        } catch {}
        return nil
    }
}
