import CoreLocation
import Foundation

extension Location {

    static func timeStamp(_ date: Date?) -> Int64 {
        if let d = date {
            return Int64(floor(d.timeIntervalSince1970 * 1000))
        } else {
            return Int64(floor(NSDate().timeIntervalSince1970 * 1000))
        }
    }

    static func from(location: CLLocation) -> Location {

        return Location(lat: location.coordinate.latitude, lng: location.coordinate.longitude, name: nil, address: nil, accuracy: location.horizontalAccuracy, provider: "CLLocationManager", timestamp: timeStamp(location.timestamp), speed: Float(location.speed), direction: Float(location.course), distance: nil, gpsEnabled: nil, type: nil, valid: nil)
    }

    static func getDistance(from: Location, to: Location) -> Double? {
        if from.lat == nil || from.lng == nil || to.lat == nil || to.lng == nil {
            return nil
        }
        let fromLocation = CLLocation(latitude: from.lat!, longitude: from.lng!)
        let toLocation = CLLocation(latitude: to.lat!, longitude: to.lng!)

        return toLocation.distance(from: fromLocation)
    }

    static func getTimeGapInSecs(from: Location, to: Location) -> Int64 {
        return (to.timestamp! - from.timestamp!) / 1000
    }

    static func getLocationUpdateRequest(location: Location) -> LocationUpdateRequestWrapper {
        return LocationUpdateRequestWrapper(location: location, batteryStatus: DeviceInfoProvider.getBatteryInfo())
    }

    static func nilLocation() -> Location {
        let nilLocation = Location(lat: nil, lng: nil, name: nil, address: nil, accuracy: nil, provider: nil, timestamp: nil, speed: nil, direction: nil, distance: nil, gpsEnabled: nil, type: nil, valid: nil)
        return nilLocation
    }

    static func isNilLocation(location: Location) -> Bool {
        return (location.lat == nil && location.lng == nil)
    }
}
