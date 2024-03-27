import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
final class CompassXException implements Exception {
  const CompassXException._({
    required this.type,
    required this.platformException,
    required this.stackTrace,
  });

  final CompassXExceptionType type;
  final PlatformException platformException;
  final StackTrace stackTrace;

  factory CompassXException.fromPlatformException({
    required PlatformException platformException,
    required StackTrace stackTrace,
  }) {
    final type = CompassXExceptionType.values.firstWhere(
      (type) => type.code == platformException.code,
      orElse: () => CompassXExceptionType.unexpected,
    );
    return CompassXException._(
      type: type,
      platformException: platformException,
      stackTrace: stackTrace,
    );
  }

  @override
  String toString() => "[CompassXException/${type.code}]: ${type.message}";
}

enum CompassXExceptionType {
  sensorNotFound,
  unexpected;

  String get code => switch (this) {
        sensorNotFound => 'SENSOR_NOT_FOUND',
        unexpected => 'UNEXPECTED',
      };

  String get message => switch (this) {
        sensorNotFound => 'Compass sensor not found.',
        unexpected => 'An unexpected error has occurred.',
      };
}
