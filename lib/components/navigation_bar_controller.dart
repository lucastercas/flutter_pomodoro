import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro_flutter/constants.dart';

import 'package:pomodoro_flutter/screens/start_screen.dart';
import 'package:pomodoro_flutter/screens/todo_start_screen.dart';

class AppBottomNavigationBarController extends StatefulWidget {
  @override
  _AppBottomNavigationBarControllerState createState() =>
      _AppBottomNavigationBarControllerState();
}

class _AppBottomNavigationBarControllerState
    extends State<AppBottomNavigationBarController> {
  final List<Widget> pages = [
    StartScreen(
      key: PageStorageKey('start_screen'),
    ),
    TodoScreen(
      key: PageStorageKey('todo_screen'),
    ),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();
  int _currentIndex = 0;

  Widget _bottomNavigationBar(int currentIndex) => BottomNavigationBar(
        selectedItemColor: kForegroundColor,
        unselectedItemColor: Colors.black,
        onTap: (int index) => setState(() => _currentIndex = index),
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list),
            title: Text('Pomodoro'),
            activeIcon: Icon(FontAwesomeIcons.listAlt),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list),
            title: Text('To Do'),
            activeIcon: Icon(FontAwesomeIcons.listAlt),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_currentIndex),
      body: PageStorage(
        child: pages[_currentIndex],
        bucket: _bucket,
      ),
    );
  }
}
