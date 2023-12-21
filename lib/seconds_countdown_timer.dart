library countdown_timer;

import 'package:flutter/widgets.dart';
import 'package:seconds_countdown_timer/seconds_current_remaining_time.dart';
import 'package:seconds_countdown_timer/seconds_countdown_timer_controller.dart';

typedef CountdownTimerWidgetBuilder = Widget Function(
    BuildContext context, SecondsCurrentRemainingTime? time);

class SecondsCountdownTimer extends StatefulWidget
    implements SecondsCountdownTimerUtils {
  const SecondsCountdownTimer({
    Key? key,
    required this.endTime,
    required this.startDate,
    this.widgetBuilder,
    this.onEnd,
  }) : super(key: key);

  /// End time in seconds
  final int endTime;

  /// start date of the timer
  final DateTime startDate;

  /// call your function when the timer`s finished
  final VoidCallback? onEnd;

  /// your customized widget goes here
  final CountdownTimerWidgetBuilder? widgetBuilder;

  @override
  State<SecondsCountdownTimer> createState() => _SecondsCountdownTimerState();
}

class _SecondsCountdownTimerState extends State<SecondsCountdownTimer> {
  late SecondsCountdownTimerController controller;

  SecondsCurrentRemainingTime? get currentRemainingTime =>
      controller.currentRemainingTime;

  CountdownTimerWidgetBuilder get widgetBuilder =>
      widget.widgetBuilder ?? builderCountdownTimer;

  void initController() {
    controller = SecondsCountdownTimerController(
      endTime: widget.endTime,
      endDate: widget.startDate,
      onEnd: widget.onEnd,
    );
    if (controller.isRunning == false) {
      controller.start();
    }
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant SecondsCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endTime != widget.endTime) {
      controller.dispose();
      initController();
    }
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, currentRemainingTime);
  }

  Widget builderCountdownTimer(
      BuildContext context, SecondsCurrentRemainingTime? time) {
    return Text("$time");
  }
}

abstract class SecondsCountdownTimerUtils {
  static String getNumberAddZero(int number) {
    if (number < 10) {
      return "0$number";
    }
    return number.toString();
  }
}
