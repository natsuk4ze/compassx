import 'package:compassx/src/compassx_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
final class CompassXPlatform {
  const CompassXPlatform._();
  static const _channel = EventChannel("studio.midoridesign/compassx");

  static final _stream = _channel.receiveBroadcastStream();

  static Stream<CompassXEvent> get events => _stream.map(CompassXEvent.fromMap);
}
