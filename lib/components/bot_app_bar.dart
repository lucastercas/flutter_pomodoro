import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pomodoro_flutter/components/navigation_icon_view.dart';
import 'package:pomodoro_flutter/constants.dart';

class BotAppBar extends StatefulWidget {
  @override
  _BotAppBar createState() => _BotAppBar();
}

class _BotAppBar extends State<BotAppBar> with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: Icon(FontAwesomeIcons.laptop),
        title: 'Pomodoro',
        color: kAccentColor,
        vsync: this,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
      NavigationIconView(
        icon: Icon(FontAwesomeIcons.list),
        activeIcon: Icon(FontAwesomeIcons.listAlt),
        title: 'To Do',
        color: kAccentColor,
        vsync: this,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/todo_screen');
        },
      ),
    ];
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
        _navigationViews[_currentIndex].doOnTap();
      },
    );
  }
}

class Aux extends StatelessWidget {
  const Aux({
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
