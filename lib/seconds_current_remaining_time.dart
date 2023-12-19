class SecondsCurrentRemainingTime {
  final int? days;
  final int? hours;
  final int? min;
  final int? sec;

  SecondsCurrentRemainingTime({this.days, this.hours, this.min, this.sec});

  @override
  String toString() {
    return 'CurrentRemainingTime{days: $days, hours: $hours, min: $min, sec: $sec';
  }
}
