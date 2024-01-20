import Flutter
import UIKit
import CoreLocation

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
        let channel = FlutterEventChannel.init(name: "studio.midoridesign/compassx", binaryMessenger: registrar.messenger())
        let instance = CompassXPlugin(channel: channel)
        registrar.publish(instance)
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        locationManager.startUpdatingHeading()
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationManager.stopUpdatingHeading()
        return nil
    }

    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        eventSink?(true)
        return false
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        eventSink?(newHeading.headingAccuracy < 0)
        eventSink?(newHeading.trueHeading >= 0 ? newHeading.trueHeading : newHeading.magneticHeading)
    }
}
