<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Seconds Countdown Timer

Add a countdown timer with a customizable widget.

## General

Create a countdown timer based on the end time (in seconds) and the start date (DateTime) of the timer. This package does not use DateTime.now, as it may be affected when the platform's date and time are changed by the user. This package is based on https://pub.dev/packages/flutter_countdown_timer.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  seconds_countdown_timer: <latest_version>
```
## Usage

```dart
import 'package:seconds_countdown_timer/seconds_countdown_timer.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: SecondsCountdownTimer(
        endTime: 60,
        startDate: DateTime.now(),
        widgetBuilder: (_, time) {
          return Text("${time?.hours ?? 0} : ${time?.min ?? 0} : ${time?.sec ?? 0}");
        },
      ),
    );
  }
}
```


