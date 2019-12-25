import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 8.0,
    this.onPressed,
    this.height,
  }) : assert(borderRadius != null);
  final double height;
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        color: color,
        disabledColor: color,
      ),
    );
  }
}
