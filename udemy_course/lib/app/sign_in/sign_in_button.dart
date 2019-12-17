import 'package:flutter/cupertino.dart';
import 'package:udemy_course/common_widgets/custom_raised_buttons.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    double height,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: 10.0,
          height: height,
        );
}
