import 'package:flutter/material.dart';
import 'package:udemy_course/app/landing_page.dart';
import 'package:udemy_course/services/auth.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Ttracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
