import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  bool testVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: kAccentColor,
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: this.testVal,
                    onChanged: (bool val) {
                      setState(() {});
                    },
                  ),
                  Text('oi', style: kLabelTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(),
    );
  }
}
