import Foundation
import UIKit

class DeviceInfoProvider {

    class func getDeviceInfo() -> DeviceInfo {

        let osName = "iOS"
        let currentDevice = UIDevice.current
        let osVersion = currentDevice.systemVersion
        let deviceType = modelIdentifier()
        let deviceId = currentDevice.identifierForVendor?.uuidString
        let deviceIdType = "INDENTIFIER_FOR_VENDOR"

        return DeviceInfo(osName: osName, osVersion: osVersion, deviceType: deviceType, deviceId: deviceId, deviceIdType: deviceIdType, registeredOn: nil, extra: nil)
    }

    private class func convertBatteryStatus(for device: UIDevice) -> BatteryStatus.ChargingStatus? {

        switch device.batteryState {

            case .unknown:
                return nil

            case .unplugged:
                return BatteryStatus.ChargingStatus._none

            case .charging:
                return BatteryStatus.ChargingStatus.charging

            case .full:
                return BatteryStatus.ChargingStatus.pluggedAc

            @unknown default:
                return nil
        }
    }

    class func getBatteryInfo() -> BatteryStatus {
        let currentDevice = UIDevice.current
        UIDevice.current.isBatteryMonitoringEnabled = true
        return BatteryStatus(charge: abs(Int(currentDevice.batteryLevel * 100)), expectedLife: nil, chargingStatus: convertBatteryStatus(for: currentDevice), timestamp: Date().milliSecondsSinceEpoch)
    }

    // taken from StackOverflow https://stackoverflow.com/a/30075200
    private class func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}

extension DeviceInfo: Equatable {
    public static func == (lhs: DeviceInfo, rhs: DeviceInfo) -> Bool {
        return lhs.deviceId == rhs.deviceId && lhs.osName == rhs.osName && lhs.deviceType == rhs.deviceType
    }
}
