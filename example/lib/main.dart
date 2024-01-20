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
              StreamBuilder<double>(
                  stream: CompassX.heading,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('No data');
                    }
                    return Text('Heading: ${snapshot.data}');
                  }),
              StreamBuilder<bool>(
                  stream: CompassX.shouldCalibrate,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('No data');
                    }
                    return Text('Should calibrate: ${snapshot.data}');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
