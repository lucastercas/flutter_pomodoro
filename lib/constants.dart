import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xff3c3836);
const kForegroundColor = Color(0xffebdbb2);

const kWorkTime = 25;
const kRestTime = 5;

const kAccentColor = Color(0xff1d2021);

const kLabelTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kForegroundColor,
);

const kClockTextStyle = TextStyle(
  fontSize: 75.0,
  fontWeight: FontWeight.bold,
  color: kForegroundColor,
);

enum PomodoroState {
  focus,
  shortPause,
  longPause,
}

const pomodoroSettings = {
  PomodoroState.focus: {
    'minutes': 0,
    'seconds': 3,
  },
  PomodoroState.longPause: {
    'minutes': 15,
    'seconds': 0,
  },
  PomodoroState.shortPause: {
    'minutes': 5,
    'seconds': 0,
  }
};
