import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants.dart';

class BotAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kAccentColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Pomodoro'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/todo_screen');
                },
                child: Text('To Do'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
