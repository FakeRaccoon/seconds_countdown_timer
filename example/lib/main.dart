import 'package:flutter/material.dart';
import 'package:seconds_countdown_timer/seconds_countdown_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SecondsCountdownTimer(
          endTime: 60,
          startDate: DateTime.now(),
          widgetBuilder: (context, time) {
            if (time == null) return const SizedBox.shrink();
            String hour =
                SecondsCountdownTimerUtils.getNumberAddZero(time.hours ?? 0);
            String min =
                SecondsCountdownTimerUtils.getNumberAddZero(time.min ?? 0);
            String sec =
                SecondsCountdownTimerUtils.getNumberAddZero(time.sec ?? 0);
            return Text("$hour : $min : $sec");
          },
        ),
      ),
    );
  }
}
