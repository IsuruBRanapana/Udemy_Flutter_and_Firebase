import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/common_widgets/platform_alert_dialog.dart';
import 'package:udemy_course/services/auth.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didConfirm = await PlatformAlertDialog(
      title: 'Confirm Sign Out',
      content: 'Do you Want to Sign Out',
      cancelActionText: 'Cancel',
      defaultActionText: 'Log out',
    ).show(context);
    if (didConfirm == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jobs',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
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
