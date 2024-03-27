import 'package:compassx/src/compassx_event.dart';
import 'package:compassx/src/compassx_platform.dart';
import 'package:flutter/foundation.dart';

/// The top-level class of compassx package.
///
/// See the [wiki](https://github.com/natsuk4ze/compassx/wiki) for details.
@immutable
final class CompassX {
  const CompassX._();

  /// [CompassXEvent] stream for using the compass sensor.
  ///
  /// Throws [CompassXException] for older or excessively cheap Android devices 
  /// that do not have a compass sensor.
  static Stream<CompassXEvent> get events => CompassXPlatform.events;
}
