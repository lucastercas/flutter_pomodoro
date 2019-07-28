import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro_flutter/constants.dart';

class PlayButton extends StatelessWidget {
  final String text;
  final Function onTap;

  PlayButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: kAccentColor,
      onPressed: this.onTap,
      child: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.playCircle,
              size: 120.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              this.text,
              style: kLabelTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
