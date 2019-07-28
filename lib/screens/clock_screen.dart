import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/clock.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreen createState() => _ClockScreen();
}

class _ClockScreen extends State<ClockScreen> {
  int minutes;
  int seconds;
  int distractions = 0;
  String activityName;
  int iterations = 0;

  @override
  Widget build(BuildContext context) {
    final ClockScreenArguments arguments =
        ModalRoute.of(context).settings.arguments;
    this.minutes = arguments.minutes;
    this.seconds = arguments.seconds;
    this.activityName = arguments.activityName;

    return Scaffold(
      appBar: AppBar(
        title: Text("${this.activityName} - ${this.iterations}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Distractions: ${this.distractions}',
              style: kLabelTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Clock(
                minutes: this.minutes,
                seconds: this.seconds,
                updateIterations: () {
                  setState(() {
                    this.iterations++;
                  });
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cancel Timer',
                style: kLabelTextStyle,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this.distractions++;
          });
        },
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: kAccentColor,
        foregroundColor: kForegroundColor,
      ),
      bottomNavigationBar: BotAppBar(),
    );
  }
}
