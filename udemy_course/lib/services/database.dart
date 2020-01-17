import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy_course/app/home/models/job.dart';
import 'package:udemy_course/services/apipath.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) async => await _setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents.map(
        (snapshot) => Job(
            name: snapshot.data['name'],
            ratePerHour: snapshot.data['ratePerHour']),
      ),
    );
  }

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path:$data');
    await reference.setData(data);
  }
}
