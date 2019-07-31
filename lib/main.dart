import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/components/navigation_bar_controller.dart';
import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/screens/clock_screen.dart';
import 'package:pomodoro_flutter/screens/start_screen.dart';
import 'package:pomodoro_flutter/screens/todo_start_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ThemeData _buildThemeData() {
    return ThemeData.dark().copyWith(
      primaryColor: Color(0xff282828),
      textTheme: TextTheme(
        body1: TextStyle(
          color: kForegroundColor,
        ),
      ),
      backgroundColor: kBackgroundColor,
      scaffoldBackgroundColor: kBackgroundColor,
      accentColor: Color(0xff1d2021),
      iconTheme: IconThemeData(
        color: kForegroundColor,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: kAccentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Flutter',
      theme: _buildThemeData(),
      home: AppBottomNavigationBarController(),
      routes: {
        'clock_screen': (context) => ClockScreen(),
      },
    );
  }
}
