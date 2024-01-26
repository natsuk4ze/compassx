import 'package:flutter/foundation.dart';

@immutable
final class CompassXEvent {
  const CompassXEvent({
    required this.heading,
    required this.accuracy,
    required this.shouldCalibrate,
  });
  final double heading;
  final double accuracy;
  final bool shouldCalibrate;

  factory CompassXEvent.fromMap(dynamic map) => CompassXEvent(
        heading: map['heading'] as double,
        accuracy: map['accuracy'] as double,
        shouldCalibrate: map['shouldCalibrate'] as bool,
      );
}
