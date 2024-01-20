import 'package:compassx/compassx_platform.dart';

final class CompassX {
  const CompassX._();

  static Stream<double> get heading => CompassXPlatform.heading;

  static Stream<bool> get shouldCalibrate => CompassXPlatform.shouldCalibrate;
}
