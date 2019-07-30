import 'package:flutter/material.dart';

import 'package:pomodoro_flutter/constants.dart';

class DialogActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const DialogActionButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: kAccentColor,
      textColor: kForegroundColor,
      child: Text(this.text),
      onPressed: this.onPressed,
    );
  }
}
