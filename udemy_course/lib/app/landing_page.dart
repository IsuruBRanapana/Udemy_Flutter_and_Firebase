import 'package:flutter/material.dart';
import 'package:udemy_course/app/home_page.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';
import 'package:udemy_course/services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<User>(
          stream: auth.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.active) {
              User user = snapshot.data;
              if (user == null) {
                return SignInPage(
                  auth: auth,
                );
              }
              return HomePage(
                auth: auth,
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}
