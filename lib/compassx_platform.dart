import 'package:flutter/services.dart';

final class CompassXPlatform {
  const CompassXPlatform._();
  static const EventChannel _channel =
      EventChannel("studio.midoridesign/compassx");

  static final Stream<dynamic> _stream = _channel.receiveBroadcastStream();

  static Stream<double> get heading =>
      _stream.where((data) => data is double).map((data) => data as double);

  static Stream<bool> get shouldCalibrate =>
      _stream.where((data) => data is bool).map((data) => data as bool);
}
