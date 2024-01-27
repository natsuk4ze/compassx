# CompassX

![Logo](https://github.com/natsuk4ze/compassx/raw/main/assets/logo.png)

### Provides reliable compass data and extensive [documentation](https://github.com/natsuk4ze/compassx/wiki).

## Usage

```dart
StreamBuilder<CompassXEvent>(
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
      ],
    );
  },
),
```

- `heading`: The heading relative to true north in degree.
- `accuracy`: The accuracy of the sensor data.
- `shouldCalibrate`: Whether the sensor should be calibrated or not.

## Install

```console
$ flutter pub add compassx
```

Check the minimum supported version of your project and update as necessary.
- **iOS: 12**
- **Android: 21**

Request permission to get true heading in Android. Not required on iOS.
```console
$ flutter pub add permission_handler
```
Specify the permissions one or both of the following in *AndroidManifest.xml*.
It can be copied from [exmaple](https://github.com/natsuk4ze/compassx/blob/main/example/android/app/src/main/AndroidManifest.xml).
```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```
- `ACCESS_COARSE_LOCATION`: Used when normal accuracy is required.
- `ACCESS_FINE_LOCATION`: Used when the highest quality accuracy is required.

Add code to request premissions.
```dart
if (!Platform.isAndroid) return;
await Permission.location.request();
```

## Precautions

**CompassX `heading` currently supports only portrait mode. It is recommended to fix the orientation of the device.**
```dart
SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
```

## Documentation

**If you are going to use this plugin in your product apps, I strongly suggest you read [wiki](https://github.com/natsuk4ze/compassx/wiki) carefully**.  
When testing, use the actual device for testing. The emulator may not provide correct sensor data.  

- [True Heading vs Magnetic Heading](https://github.com/natsuk4ze/compassx/wiki#true-heading)
- [How to calibrate your device's compass](https://github.com/natsuk4ze/compassx/wiki#calibration)
- [Testing CompassX](https://github.com/natsuk4ze/compassx/wiki#checking-the-accuracy-of-compassx)