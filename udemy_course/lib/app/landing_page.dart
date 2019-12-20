import 'package:flutter/material.dart';
import 'package:udemy_course/app/home_page.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';
import 'package:udemy_course/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState(){
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async{
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }
  void _updateUser(User user){
    setState(() {
      _user=user;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: (user)=>_updateUser(user),
      );
    }
      return HomePage(
        auth: widget.auth,
        onSignOut: ()=> _updateUser(null),
      );
  }
}
