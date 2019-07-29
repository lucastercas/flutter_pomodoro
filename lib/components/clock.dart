import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pomodoro_flutter/constants.dart';

class Clock extends StatefulWidget {
  final PomodoroState state;
  final Function updateIterations;
  final Function onClockEnd;

  Clock({
    @required this.state,
    @required this.updateIterations,
    @required this.onClockEnd,
  });

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  int minutes;
  int seconds;
  Timer timer;

  void _startTimer() {
    this.timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => this._getCurrentTime(),
    );
  }

  void _getCurrentTime() {
    if (this.seconds == 0 && this.minutes == 0) {
      this.timer.cancel();
      widget.onClockEnd();
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
    this.minutes = pomodoroSettings[widget.state]['minutes'];
    this.seconds = pomodoroSettings[widget.state]['seconds'];
    this._startTimer();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print('Updating Clock');
    this._initClock();
    print(widget.state);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: pq da erro se eu chamar _initClock aqui?
    this.minutes = pomodoroSettings[widget.state]['minutes'];
    this.seconds = pomodoroSettings[widget.state]['seconds'];
    this._startTimer();
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        if (this.minutes == 0 && this.seconds == 0) {
          widget.onClockEnd();
        } else {
          this.timer.isActive ? this.timer.cancel() : this._startTimer();
        }
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
