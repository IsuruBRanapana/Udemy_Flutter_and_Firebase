import 'package:flutter/foundation.dart';
import 'package:udemy_course/app/home/models/job.dart';
import 'package:udemy_course/services/apipath.dart';
import 'package:udemy_course/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDateAndTime()=>DateTime.now().toIso8601String();
class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service=FirestoreService.instance;
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data,documentId) => Job.fromMap(data,documentId),
      );

}
