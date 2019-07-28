import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'dart:async';

class Clock extends StatefulWidget {
  final int minutes;
  final int seconds;
  final Function updateIterations;

  Clock(
      {@required this.minutes,
      @required this.seconds,
      @required this.updateIterations});

  @override
  _ClockState createState() => _ClockState(
        minutes: this.minutes,
        seconds: this.seconds,
        updateIterations: this.updateIterations,
      );
}

class _ClockState extends State<Clock> {
  int initialMinutes;
  int initialSeconds;
  int minutes;
  int seconds;

  Timer timer;
  Function updateIterations;

  _ClockState({
    this.minutes,
    this.seconds,
    this.updateIterations,
  });

  @override
  void initState() {
    this.initialMinutes = this.minutes;
    this.initialSeconds = this.seconds;
    this._startTimer();
    super.initState();
  }

  void _startTimer() {
    this.timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => this._getCurrentTime(),
    );
  }

  void _restartClock() {
    setState(() {
      this.minutes = this.initialMinutes;
      this.seconds = this.initialSeconds;
    });
    this._startTimer();
  }

  void _getCurrentTime() {
    if (this.seconds == 0 && this.minutes == 0) {
      this.timer.cancel();
      showDialog(
        barrierDismissible: false,
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Timer End'),
            actions: <Widget>[
              RaisedButton(
                color: kAccentColor,
                child: Text('Go Back'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              RaisedButton(
                  color: kAccentColor,
                  child: Text('Start Again'),
                  onPressed: () {
                    this.updateIterations();
                    this._restartClock();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        },
      );
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

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: kAccentColor,
      onPressed: () {
        this.timer.isActive ? this.timer.cancel() : this._startTimer();
      },
      child: Padding(
        padding: EdgeInsets.all(75.0),
        child: Text(
          "${minutes}:${seconds < 10 ? '0' + seconds.toString() : seconds}",
          style: kClockTextStyle,
        ),
      ),
    );
  }
}
