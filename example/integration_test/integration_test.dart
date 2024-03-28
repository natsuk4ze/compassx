import 'dart:io' show Platform;

import 'package:compassx_example/main.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test', (tester) async {
    await tester.pumpWidget(const App());

    /// Wait while data is being acquired and the
    /// [CircularProgressIndicator] is displayed.
    await tester.pumpAndSettle();

    /// Ensure that the Android SDK 23 and lower emulators and the iOS 
    /// simulator do not have a heading sensor, so that an Exception is Throw.
    Platform.isAndroid &&
            (await DeviceInfoPlugin().androidInfo).version.sdkInt > 23
        ? expect(find.textContaining('Heading'), findsOneWidget)
        : expect(find.textContaining('CompassXException'), findsOneWidget);
  });
}
