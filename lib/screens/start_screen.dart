import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/play_button.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

enum PomodoroState {
  work,
  rest,
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  String title = 'Pomodoro';
  int minutes = kWorkTime;
  int seconds = 5;
  String buttonText = 'Change to Rest';
  PomodoroState state = PomodoroState.work;

/*
  @override
  void initState() {
    super.initState();
    var data = {
      'title': 'iae',
      'author': 'test',
    };
    try {
      Firestore.instance.collection('timers').document().setData(data);
    } catch (e) {
      print(e);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlayButton(
              text: "${this.minutes}:${'0' + this.seconds.toString()}",
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/clock_screen',
                  arguments: ClockScreenArguments(
                      minutes: this.minutes,
                      seconds: this.seconds,
                      activityName: 'una-sus'),
                );
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                this.buttonText,
                style: kLabelTextStyle,
              ),
              onPressed: () {
                setState(() {
                  if (this.state == PomodoroState.rest) {
                    this.state = PomodoroState.work;
                    this.buttonText = 'Change to Rest';
                    this.minutes = kWorkTime;
                  } else if (this.state == PomodoroState.work) {
                    this.state = PomodoroState.rest;
                    this.buttonText = 'Change to Work';
                    this.minutes = kRestTime;
                  }
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(),
    );
  }
}
