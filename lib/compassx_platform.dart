import 'package:flutter/services.dart';

final class CompassXPlatform {
  const CompassXPlatform._();
  static const EventChannel _channel =
      EventChannel("studio.midoridesign/compassx");
}
