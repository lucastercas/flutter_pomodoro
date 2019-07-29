import 'package:flutter/material.dart';

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
  String activityName;

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
                showDialog(
                  context: this.context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Start Time"),
                      content: TextField(
                        controller: this.textController,
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          color: kAccentColor,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/clock_screen',
                              arguments: ClockScreenArguments(
                                minutes: this.minutes,
                                seconds: this.seconds,
                                activityName: this.textController.text,
                              ),
                            );
                          },
                          child: Text("Start"),
                        ),
                      ],
                    );
                  },
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
