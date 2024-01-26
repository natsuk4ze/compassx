import 'package:flutter/foundation.dart';

// Event data obtained by [CompassXPlatform] from the native side.
//
// See the [wiki](https://github.com/natsuk4ze/compassx/wiki) for details.
@immutable
final class CompassXEvent {
  const CompassXEvent({
    required this.heading,
    required this.accuracy,
    required this.shouldCalibrate,
  });

  // The heading relative to true north in degree.
  //
  // The value in this property represents the heading relative to the
  // geographic North Pole. The value 0 means the device is pointed toward
  // true north, 90 means it is pointed due east.
  // Changes of less than 0.1 will not be detected.
  // On Android, magnetic heading is returned until permission to
  // retrieve location data is granted.
  // In iOS, magnetic heading is returned if true heading cannot be calculated,
  // but this is a very rare case and should not be a concern.
  final double heading;

  // The accuracy of the sensor data in degrees.
  //
  // This value represents the estimation error of reported [heading].
  // For example, if [heading] is 90 and this value is 10,
  // the actual value is likely to be between 100 and 80.
  // In other words, the lower this value, the higher the accuracy. However,
  // if it cannot be measured, it is set to -1. This can be when the magnetic
  // field changes rapidly or when the sensors on the device do not provide accuracy.
  final double accuracy;

  // Whether the sensor should be calibrated or not.
  //
  // If this value is true, the sensor values are unreliable and should.
  // See the [wiki](https://github.com/natsuk4ze/compassx/wiki) for
  // calibration instructions.
  final bool shouldCalibrate;

  // Factory for the map data obtained from the stream of [EventChannel].
  factory CompassXEvent.fromMap(dynamic map) => CompassXEvent(
        heading: map['heading'] as double,
        accuracy: map['accuracy'] as double,
        shouldCalibrate: map['shouldCalibrate'] as bool,
      );
}
