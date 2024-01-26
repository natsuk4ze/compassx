import 'dart:io';

import 'package:compassx/compassx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineSmall!,
          child: Center(
            child: StreamBuilder<CompassXEvent>(
              stream: CompassX.events,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('No data');
                final compass = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Heading: ${compass.heading}'),
                    Text('Accuracy: ${compass.accuracy}'),
                    Text('Should calibrate: ${compass.shouldCalibrate}'),
                    Transform.rotate(
                      angle: compass.heading * math.pi / 180,
                      child: Icon(
                        Icons.arrow_upward_rounded,
                        size: MediaQuery.of(context).size.width - 80,
                      ),
                    ),
                    FilledButton(
                      onPressed: () async {
                        if (!Platform.isAndroid) return;
                        await Permission.location.request();
                      },
                      child: const Text('Request permission'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
