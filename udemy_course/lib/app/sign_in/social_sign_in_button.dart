import 'package:flutter/cupertino.dart';
import 'package:udemy_course/common_widgets/custom_raised_buttons.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    String assetName,
    String text,
    Color color,
    Color textColor,
    double height,
    VoidCallback onPressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 15.0
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              )
            ],
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: 10.0,
          height: height,
        );
}
