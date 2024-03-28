import 'dart:io' show Platform;

import 'package:compassx_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test', (tester) async {
    await tester.pumpWidget(const App());

    /// Wait while data is being acquired and the 
    /// [CircularProgressIndicator] is displayed.
    await tester.pumpAndSettle();

    // On Android, the Heading can be obtained.but on the 
    // on iOS simulator, the Heading sensor is not available, 
    // so the [CompassXException] is confirmed to be Throw.
    final pattern = Platform.isAndroid ? 'Heading' : 'CompassXException';

    expect(find.textContaining(pattern), findsOneWidget);
  });
}
