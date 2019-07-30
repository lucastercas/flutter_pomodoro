import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';
import 'package:pomodoro_flutter/components/todo_item.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  void _getTodos() {
    CollectionReference todoCol = Firestore.instance.collection("todos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TodoItem(),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
