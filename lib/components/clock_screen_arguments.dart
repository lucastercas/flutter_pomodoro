import 'package:pomodoro_flutter/constants.dart';
import 'package:flutter/material.dart';

class ClockScreenArguments {
  final PomodoroState state;
  final String activityName;

  ClockScreenArguments({@required this.state, @required this.activityName});
}
