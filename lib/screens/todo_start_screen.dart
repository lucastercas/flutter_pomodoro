import 'package:flutter/material.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/bot_app_bar.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(),
      bottomNavigationBar: BotAppBar(),
    );
  }
}
