import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seconds_countdown_timer/seconds_current_remaining_time.dart';

class SecondsCountdownTimerController extends ChangeNotifier {
  SecondsCountdownTimerController({
    required int endTime,
    required DateTime endDate,
    this.onEnd,
  })  : _endTime = endTime,
        _startDate = endDate;

  /// DateTime when timer started
  final DateTime? _startDate;

  /// call your function on timer's end
  final VoidCallback? onEnd;

  /// End time in seconds
  int _endTime;
  DateTime? _endDate;
  Timer? _timer;
  bool _isRunning = false;
  SecondsCurrentRemainingTime? _currentRemainingTime;

  /// Seconds in a day
  final int _daySecond = 60 * 60 * 24;

  /// Seconds in an hour
  final int _hourSecond = 60 * 60;

  /// Seconds in a minute
  final int _minuteSecond = 60;

  bool get isRunning => _isRunning;

  SecondsCurrentRemainingTime? get currentRemainingTime =>
      _currentRemainingTime;

  set endTime(int endTime) => _endTime = endTime;

  void start() {
    _disposeTimer();
    _isRunning = true;
    var epoch = _startDate!.millisecondsSinceEpoch + (_endTime * 1000);
    _endDate = DateTime.fromMillisecondsSinceEpoch(epoch);
    _onPeriodic();
    if (_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _onPeriodic();
      });
    }
  }

  void _onPeriodic() {
    _currentRemainingTime = _calculateRemainingTime();
    notifyListeners();
    if (_currentRemainingTime == null) {
      onEnd?.call();
      _disposeTimer();
    }
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// calculate date difference based on endtime provided
  SecondsCurrentRemainingTime? _calculateRemainingTime() {
    var endEpoch = _endDate!.millisecondsSinceEpoch - 1000;
    _endDate = DateTime.fromMillisecondsSinceEpoch(endEpoch);
    int remaining =
        ((endEpoch - _startDate!.millisecondsSinceEpoch) / 1000).floor();

    if (remaining <= 0) return null;

    int? days, hours, min, sec;

    /// Calculate the number of days remaining.
    if (remaining >= _daySecond) {
      days = (remaining / _daySecond).floor();
      remaining -= days * _daySecond;
    }

    /// Calculate remaining hours.
    if (remaining >= _hourSecond) {
      hours = (remaining / _hourSecond).floor();
      remaining -= hours * _hourSecond;
    } else if (days != null) {
      hours = 0;
    }

    /// Calculate remaining minutes.
    if (remaining >= _minuteSecond) {
      min = (remaining / _minuteSecond).floor();
      remaining -= min * _minuteSecond;
    } else if (hours != null) {
      min = 0;
    }

    sec = remaining.toInt();

    return SecondsCurrentRemainingTime(
        days: days, hours: hours, min: min, sec: sec);
  }

  @override
  void dispose() {
    _disposeTimer();
    super.dispose();
  }
}
