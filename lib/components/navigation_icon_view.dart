import 'package:flutter/material.dart';

class NavigationIconView {
  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Function onTap;
  Animation<double> _animation;

  NavigationIconView(
      {Widget icon,
      Widget activeIcon,
      String title,
      Color color,
      Function onTap,
      TickerProvider vsync})
      : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(title),
            backgroundColor: color),
        controller = AnimationController(
          duration: Duration(milliseconds: 200),
          vsync: vsync,
        ) {
    _animation = controller.drive(
      CurveTween(
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  void doOnTap() {
    this.onTap();
    print('iae');
  }

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02),
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 50.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}
