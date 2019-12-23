import 'package:flutter/material.dart';
import 'package:udemy_course/app/sign_in/email_sign_in_form.dart';


class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: Card(
        margin: EdgeInsets.all(10.0),
          child: EmailSignInForm(),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
