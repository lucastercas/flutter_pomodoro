import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pomodoro_flutter/constants.dart';

class TodoItem extends StatefulWidget {
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAccentColor,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isChecked,
            onChanged: (bool val) {
              setState(() {
                isChecked = !isChecked;
              });
            },
          ),
          Text('oi', style: kLabelTextStyle),
        ],
      ),
    );
  }
}
