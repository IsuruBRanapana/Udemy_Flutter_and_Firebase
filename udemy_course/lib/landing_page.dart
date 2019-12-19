import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;
  void _updateUser(FirebaseUser user){
    print('User Id:${user.uid}');
  }
  @override
  Widget build(BuildContext context) {
    if (_user==null){
      return SignInPage(
        onSignIn: _updateUser,
      );
    }else{
      return Container();
    }

  }
}
