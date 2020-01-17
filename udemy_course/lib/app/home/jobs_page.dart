import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/app/home/models/job.dart';
import 'package:udemy_course/common_widgets/platform_alert_dialog.dart';
import 'package:udemy_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:udemy_course/services/database.dart';
import 'package:flutter/services.dart';

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

  Future<void> _createJob(BuildContext context) async {
    try{
    final database = Provider.of<Database>(context);
    await database.createJob(Job(
      name: 'Painting',
      ratePerHour: 12,
    ));}on PlatformException catch (e){
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
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
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database= Provider.of<Database>(context);
    return StreamBuilder <List<Job>>(
      stream: database.jobsStream(),
      builder: (context,snapshot){
        if (snapshot.hasData){
          final jobs=snapshot.data;
          final children= jobs.map((job)=> Text(job.name)).toList();
          return ListView(
            children: children,
          );
        }if (snapshot.hasError){
          return Center(child: Text('Some Error Occured'),);
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
