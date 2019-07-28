import 'package:flutter/material.dart';

class ClockScreenArguments {
  final int minutes;
  final int seconds;
  final String activityName;

  ClockScreenArguments({
    @required this.minutes,
    @required this.seconds,
    @required this.activityName
  });
}
