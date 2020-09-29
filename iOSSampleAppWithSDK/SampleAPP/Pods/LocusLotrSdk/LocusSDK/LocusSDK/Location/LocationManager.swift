import CoreLocation
import Foundation
import RxCoreLocation
import RxSwift

class LocationManager {

    static let shared = LocationManager()

    let dispose = DisposeBag()
    let locationManager = CLLocationManager()
    private var previousLocation: Location?
    private var locationManagerStated = false
    let permission = BehaviorSubject<CLAuthorizationStatus>(value: CLLocationManager.authorizationStatus())

    private init() {

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        if #available(iOS 11.0, *) {
            locationManager.showsBackgroundLocationIndicator = false
        }
        locationManager.rx.didChangeAuthorization.subscribe(onNext: { _, status in
            self.permission.onNext(status)
        }).disposed(by: dispose)
    }

    private func shouldUpdate(_ location: Location) -> Bool {

        guard let previousLocation = self.previousLocation else {
            return true
        }

        let distance = Location.getDistance(from: previousLocation, to: location)
        let timeGap = Location.getTimeGapInSecs(from: previousLocation, to: location)

        let userPollingParams = Provider.getDataManager().clientAppConfig?.userLocationPollingParam

        let minTimeGap = userPollingParams?.minTimeGap ?? 5

        if timeGap < minTimeGap {
            return false
        }

        let maxTimeGap = userPollingParams?.maxTimeGap ?? 60
        let minChange = userPollingParams?.minChange ?? 30
        return Int(distance ?? 0.0) >= minChange || timeGap >= Int64(maxTimeGap)
    }

    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startLocationServices() {
        requestAuthorization()
        locationManagerStated = true
        locationManager.startUpdatingLocation()
    }

    func getLocationUpdates() -> Observable<Location> {
        return locationManager.rx.location
            .filter {
                location -> Bool in
                location != nil
            }.map {
                location -> Location in
                Location.from(location: location!)
            }
            .filter {
                location -> Bool in
                if self.shouldUpdate(location) {
                    self.previousLocation = location
                    return true
                }
                return false
            }
    }

    func getLastKnownLocation() -> Location? {
        if let location = previousLocation {
            return location
        }
        return nil
    }

    func stopLocationServices() {
        locationManagerStated = false
        locationManager.stopUpdatingLocation()
    }
}
