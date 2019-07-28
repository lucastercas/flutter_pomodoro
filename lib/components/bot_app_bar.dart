import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants.dart';

class BotAppBar extends StatelessWidget {
  const BotAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kAccentColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {},
                child: Text('Pomodoro'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {},
                child: Text('To Do'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
