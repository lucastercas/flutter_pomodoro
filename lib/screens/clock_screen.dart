import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/clock.dart';
import 'package:pomodoro_flutter/components/dialog_action_button.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreen createState() => _ClockScreen();
}

class _ClockScreen extends State<ClockScreen> {
  PomodoroState state;

  int distractions = 0;
  String activityName;
  int iterations = 0;
  Widget clock;

  void _updateDatabase() async {
    DateTime date = DateTime.now();
    String docName = "${date.year}-${date.month}-${date.day}";

    DocumentReference docRef =
        Firestore.instance.collection('timers').document(docName);
    DocumentSnapshot docSnap = await docRef.get();

    if (docSnap == null) {
      print('Document Not Found');
      return;
    }

    try {
      Map data = docSnap.data;
      if (data == null) {
        print('Data Not Found');
        docRef.setData({
          activityName: {
            'distractions': this.distractions,
            'iterations': 1,
          }
        });
        return;
      }

      data.update(
        this.activityName,
        (dynamic val) => {
          'distractions': val['distractions'],
          'iterations': ++val['iterations']
        },
        ifAbsent: () => {
          'distractions': this.distractions,
          'iterations': this.iterations,
        },
      );
      docRef.setData(data);
    } catch (e) {
      print(e);
    }
  }

  void _onClockEnd() {
    this.iterations++;
    _updateDatabase();
    _showDialog();
  }

  void _showDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timer End'),
          actions: <Widget>[
            DialogActionButton(
              text: 'Focus',
              onPressed: () {
                setState(() {
                  this.state = PomodoroState.focus;
                  this.clock = null;
                  Navigator.of(context).pop();
                  this.clock = _buildClock();
                });
              },
            ),
            DialogActionButton(
              text: 'Short',
              onPressed: () {
                setState(() {
                  this.state = PomodoroState.shortPause;
                  this.clock = null;
                  Navigator.of(context).pop();
                  this.clock = _buildClock();
                });
              },
            ),
            DialogActionButton(
              text: 'Long',
              onPressed: () {
                setState(() {
                  this.state = PomodoroState.longPause;
                  this.clock = null;
                });
              },
            )
          ],
        );
      },
    );
  }

  Clock _buildClock() {
    Clock newClock = new Clock(
      state: this.state,
      updateIterations: () {
        setState(() {
          this.iterations++;
        });
      },
      onClockEnd: () {
        this._onClockEnd();
      },
    );
    return newClock;
  }

  void _getInitialArguments() {
    final ClockScreenArguments arguments =
        ModalRoute.of(context).settings.arguments;
    this.state = arguments.state;
    this.activityName = arguments.activityName;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._getInitialArguments();
    this.clock = this._buildClock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.activityName} - ${this.iterations}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: this.clock,
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
            ),
            Text(
              'Distractions: ${this.distractions}',
              style: kLabelTextStyle,
            ),
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
