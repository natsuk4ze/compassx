import 'package:compassx/compassx.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<CompassXEvent>(
                  stream: CompassX.events,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('No data');
                    final compass = snapshot.data!;
                    return Column(
                      children: [
                        Text('Heading: ${compass.heading}'),
                        Text('Accuracy: ${compass.accuracy}'),
                        Text('Should calibrate: ${compass.shouldCalibrate}'),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
