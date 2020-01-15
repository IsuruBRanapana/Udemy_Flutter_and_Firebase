import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/app/home/jobs_page.dart';
import 'package:udemy_course/app/sign_in/sign_in.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:udemy_course/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthBase>(context);
    return Container(
      child: StreamBuilder<User>(
          stream: auth.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.active) {
              User user = snapshot.data;
              if (user == null) {
                return SignInPage.create(context);
              }
              return Provider<Database>(
                create: (_)=>FirestoreDatabase(uid: user.uid),
                  child: JobsPage());
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}
