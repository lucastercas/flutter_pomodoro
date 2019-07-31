import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pomodoro_flutter/constants.dart';

class TodoItem extends StatefulWidget {
  final String activity;
  final bool done;
  final DocumentSnapshot docSnapshot;

  TodoItem({
    @required this.activity,
    @required this.done,
    this.docSnapshot,
    Key key,
  }) : super(key: key);
  @override
  _TodoItemState createState() => _TodoItemState(done, docSnapshot);
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked;
  DocumentSnapshot docSnap;

  _TodoItemState(this.isChecked, this.docSnap);
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
                docSnap.reference.updateData({
                  'done': isChecked,
                });
              });
            },
          ),
          Text(widget.activity, style: kLabelTextStyle),
        ],
      ),
    );
  }
}
