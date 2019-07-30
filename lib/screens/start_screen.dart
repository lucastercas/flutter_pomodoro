import 'package:flutter/material.dart';

import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/dialog_action_button.dart';
import 'package:pomodoro_flutter/components/play_button.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  String title = 'Pomodoro';
  String buttonText = 'Change to Short Pause';
  PomodoroState state = PomodoroState.focus;
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
                        DialogActionButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/clock_screen',
                              arguments: ClockScreenArguments(
                                state: this.state,
                                activityName: this.textController.text,
                              ),
                            );
                          },
                          text: "Start",
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Chip(
              label: Text(
                  "${pomodoroSettings[this.state]['minutes']}:${'0' + pomodoroSettings[this.state]['seconds'].toString()}"),
              backgroundColor: kAccentColor,
              labelStyle: TextStyle(color: kForegroundColor),
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
                  if (this.state == PomodoroState.focus) {
                    this.state = PomodoroState.shortPause;
                    this.buttonText = 'Change to Long Pause';
                  } else if (this.state == PomodoroState.shortPause) {
                    this.state = PomodoroState.longPause;
                    this.buttonText = 'Change to Focus';
                  } else if (this.state == PomodoroState.longPause) {
                    this.state = PomodoroState.focus;
                    this.buttonText = 'Change to Short Pause';
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
