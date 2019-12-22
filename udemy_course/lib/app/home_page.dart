import 'package:flutter/material.dart';
import 'package:udemy_course/services/auth.dart';

class HomePage extends StatelessWidget {

  HomePage({@required this.auth});
  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
        ),
        actions: <Widget>[
          FlatButton(
              onPressed:_signOut,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
          ),
        ],
      ),
    );
  }
}
