import 'package:flutter/material.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Ttracker',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: SignInPage(),
    );
  }
}
