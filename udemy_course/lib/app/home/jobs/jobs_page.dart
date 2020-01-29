import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/app/home/job_entries/job_entries_page.dart';
import 'package:udemy_course/app/home/jobs/edit_job_page.dart';
import 'package:udemy_course/app/home/jobs/empty_content.dart';
import 'package:udemy_course/app/home/jobs/job_list_tile.dart';
import 'package:udemy_course/app/home/jobs/list_item_builder.dart';
import 'package:udemy_course/app/home/models/job.dart';
import 'package:udemy_course/common_widgets/platform_alert_dialog.dart';
import 'package:udemy_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:udemy_course/services/database.dart';
import 'package:flutter/services.dart';

class JobsPage extends StatelessWidget {

  Future<void> _delete(BuildContext context, Job job) async{
    try{
      final database=Provider.of<Database>(context);
      await database.deleteJob(job);
    }on PlatformException catch(e){
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
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            onPressed: () => EditJobPage.show(context,database: Provider.of<Database>(context)),
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context,job)=>Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red,),
            direction: DismissDirection.endToStart,
            onDismissed: (direction)=>_delete(context,job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          )
        );
      },
    );
  }

}
