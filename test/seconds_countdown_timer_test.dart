import 'package:flutter_test/flutter_test.dart';
import 'package:seconds_countdown_timer/seconds_countdown_timer.dart';

void main() {
  test('adds one to input values', () {
    SecondsCountdownTimer(
      startDate: DateTime.now(),
      endTime: 60 * 60,
    );
  });
}
