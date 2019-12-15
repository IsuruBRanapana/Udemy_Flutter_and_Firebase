import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        'Sign in with Google',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 15.0,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      onPressed: () {
        print('Button pressed');
      },
      color: Colors.white,
    );
  }
}
