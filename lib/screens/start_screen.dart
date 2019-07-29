import 'package:flutter/material.dart';

import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/play_button.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  String title = 'Pomodoro';
  String buttonText = 'Change to Short Rest';

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
              text:
                  "${pomodoroSettings[this.state]['minutes']}:${'0' + pomodoroSettings[this.state]['seconds'].toString()}",
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
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pushReplacementNamed(
                              context,
                              '/clock_screen',
                              arguments: ClockScreenArguments(
                                state: this.state,
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
                  if (this.state == PomodoroState.focus) {
                    this.state = PomodoroState.shortRest;
                    this.buttonText = "Change to Long Rest";
                  } else if (this.state == PomodoroState.shortRest) {
                    this.state = PomodoroState.longRest;
                    this.buttonText = "Change to Focus";
                  } else if (this.state == PomodoroState.longRest) {
                    this.state = PomodoroState.focus;
                    this.buttonText = "Change to Short Rest";
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
