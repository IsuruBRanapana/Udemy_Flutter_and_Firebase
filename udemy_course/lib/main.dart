import 'package:flutter/material.dart';
import 'package:udemy_course/app/landing_page.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Ttracker',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: LandingPage(),
      ),
    );
  }
}
