import 'package:compassx/src/compassx_event.dart';
import 'package:compassx/src/compassx_platform.dart';
import 'package:flutter/foundation.dart';

@immutable
final class CompassX {
  const CompassX._();

  static Stream<CompassXEvent> get events => CompassXPlatform.events;
}
