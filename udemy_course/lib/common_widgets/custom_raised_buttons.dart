import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  CustomRaisedButton({this.child,this.color,this.borderRadius,this.onPressed});
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      color: color,
    );
  }
}
