import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xff3c3836);
const kForegroundColor = Color(0xffebdbb2);

const kWorkTime = 25;
const kRestTime = 5;

const kAccentColor = Color(0xff1d2021);

const kLabelTextStyle = TextStyle(
    fontSize: 25.0, fontWeight: FontWeight.bold, color: kForegroundColor);

const kClockTextStyle = TextStyle(
    fontSize: 75.0, fontWeight: FontWeight.bold, color: kForegroundColor);

enum PomodoroState {
  focus,
  shortRest,
  longRest,
}

const pomodoroSettings = {
  PomodoroState.focus: {
    'minutes': 25,
    'seconds': 0,
  },
  PomodoroState.shortRest: {
    'minutes': 0,
    'seconds': 3,
  },
  PomodoroState.longRest: {
    'minutes': 15,
    'seconds': 0,
  },
};
