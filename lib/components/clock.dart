import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pomodoro_flutter/constants.dart';

class Clock extends StatefulWidget {
  final int minutes;
  final int seconds;
  final Function updateIterations;
  final Function onClockEnd;

  Clock({
    @required this.minutes,
    @required this.seconds,
    @required this.updateIterations,
    @required this.onClockEnd,
  });

  void reset() {
    this.createState();
  }

  @override
  _ClockState createState() => _ClockState(
      minutes: this.minutes,
      seconds: this.seconds,
      updateIterations: this.updateIterations,
      onClockEnd: this.onClockEnd);
}

class _ClockState extends State<Clock> {
  int minutes;
  int seconds;
  int initialMinutes;
  int initialSeconds;
  Function updateIterations;
  Function onClockEnd;

  Timer timer;

  _ClockState({
    @required this.minutes,
    @required this.seconds,
    @required this.updateIterations,
    @required this.onClockEnd,
  });

  void _startTimer() {
    this.timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => this._getCurrentTime(),
    );
  }

  void _getCurrentTime() {
    if (this.seconds == 0 && this.minutes == 0) {
      this.timer.cancel();
      this.onClockEnd();
      return;
    }
    setState(() {
      if (this.seconds > 0) {
        this.seconds--;
      } else {
        this.minutes--;
        this.seconds = 59;
      }
    });
  }

  void _initClock() {
    this.minutes = this.initialMinutes;
    this.seconds = this.initialSeconds;
    this._startTimer();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._initClock();
  }

  @override
  void initState() {
    super.initState();
    this.initialMinutes = this.minutes;
    this.initialSeconds = this.seconds;
    this._startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    this.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        this.timer.isActive ? this.timer.cancel() : this._startTimer();
      },
      shape: CircleBorder(),
      fillColor: kAccentColor,
      child: Padding(
        padding: EdgeInsets.all(75.0),
        child: Text(
          "${this.minutes}:${this.seconds < 10 ? '0' + this.seconds.toString() : this.seconds}",
          style: kClockTextStyle,
        ),
      ),
    );
  }
}
