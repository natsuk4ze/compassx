import 'package:compassx/src/compassx_event.dart';
import 'package:compassx/src/compassx_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The platform interface for receiving data from native side.
@immutable
final class CompassXPlatform {
  const CompassXPlatform._();

  /// The [EventChannel] used for receiving events from the native side.
  static const _channel = EventChannel("studio.midoridesign/compassx");

  /// The stream used for receiving events from the native side.
  static final _stream = _channel.receiveBroadcastStream();

  /// CompassXEvent stream for [CompassX].
  static Stream<CompassXEvent> get events =>
      _stream.map(CompassXEvent.fromMap).handleError(
            (e, st) => throw CompassXException.fromPlatformException(
              platformException: e,
              stackTrace: st,
            ),
            test: (e) => e is PlatformException,
          );
}
