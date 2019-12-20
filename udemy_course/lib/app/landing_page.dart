import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/app/home_page.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;

  void _updateUser(FirebaseUser user){
    setState(() {
      _user=user;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: (user)=>_updateUser(user),
      );
    }
      return HomePage(
        onSignOut: ()=> _updateUser(null),
      );
  }
}
