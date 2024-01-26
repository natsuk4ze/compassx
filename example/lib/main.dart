import 'package:compassx/compassx.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineSmall!,
          child: Center(
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
                        Transform.rotate(
                          angle: compass.heading * math.pi / 180,
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            size: MediaQuery.of(context).size.width - 80,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
