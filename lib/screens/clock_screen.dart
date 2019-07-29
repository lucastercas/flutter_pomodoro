import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/clock_screen_arguments.dart';
import 'package:pomodoro_flutter/components/clock.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreen createState() => _ClockScreen();
}

class _ClockScreen extends State<ClockScreen> {
  String activityName;
  PomodoroState state;

  int distractions = 0;
  int iterations = 0;
  Widget clock;

  void _updateDatabase() async {
    DateTime date = DateTime.now();
    String docName = "${date.year}-${date.month}-${date.day}";
    DocumentSnapshot docSnap =
        await Firestore.instance.collection('timers').document(docName).get();
    Map data = docSnap.data;

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

    Firestore.instance.collection('timers').document(docName).setData(data);
  }

  void _onClockEnd() {
    this.iterations++;
    this._updateDatabase();
    _showEndDialog();
  }

  void _showEndDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timer End'),
          actions: <Widget>[
            RaisedButton(
              color: kAccentColor,
              child: Text('Focus'),
              onPressed: () {
                setState(() {
                  this.clock = _buildClock(pomState: PomodoroState.focus);
                });
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: kAccentColor,
              child: Text('Short Pause'),
              onPressed: () {
                setState(() {
                  this.clock = _buildClock(pomState: PomodoroState.shortRest);
                });
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: kAccentColor,
              child: Text('Long Pause'),
              onPressed: () {
                setState(() {
                  this.clock = _buildClock(pomState: PomodoroState.longRest);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Clock _buildClock({PomodoroState pomState}) {
    print(pomState);
    Clock newClock = new Clock(
      state: pomState != null ? pomState : this.state,
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
  void initState() {
    super.initState();
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
            Text(
              'Distractions: ${this.distractions}',
              style: kLabelTextStyle,
            ),
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
