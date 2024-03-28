import CoreLocation
import Flutter
import UIKit

public class CompassXPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager
    private var eventSink: FlutterEventSink?

    init(channel: FlutterEventChannel) {
        locationManager = CLLocationManager()
        super.init()
        channel.setStreamHandler(self)
        locationManager.delegate = self
        locationManager.headingFilter = 0.1
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "studio.midoridesign/compassx", binaryMessenger: registrar.messenger())
        let instance = CompassXPlugin(channel: channel)
        registrar.publish(instance)
    }

    public func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        let isHeadingAvailable = CLLocationManager.headingAvailable()
        if !isHeadingAvailable {
            eventSink?(FlutterError(code: "SENSOR_NOT_FOUND", message: "No compass sensor found.", details: nil))
            return nil
        }
        locationManager.startUpdatingHeading()
        return nil
    }

    public func onCancel(withArguments _: Any?) -> FlutterError? {
        locationManager.stopUpdatingHeading()
        return nil
    }

    public func locationManagerShouldDisplayHeadingCalibration(_: CLLocationManager) -> Bool {
        // This callback could be added to "shouldCalibrate".

        return false
    }

    public func locationManager(_: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = newHeading.trueHeading >= 0 ? newHeading.trueHeading : newHeading.magneticHeading
        let accuracy = newHeading.headingAccuracy
        let shouldCalibrate = accuracy < 0
        eventSink?(["heading": heading, "accuracy": accuracy, "shouldCalibrate": shouldCalibrate])
    }
}
