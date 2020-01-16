import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy_course/app/home/models/job.dart';
import 'package:udemy_course/services/apipath.dart';

abstract class Database{
  Future <void> createJob(Job job);
}

class FirestoreDatabase extends Database{
  FirestoreDatabase({@required this.uid}): assert(uid != null);
  final String uid;

  Future <void> createJob(Job job) async=>await _setData(
    path: APIPath.job(uid, 'job_abc'),
    data: job.toMap(),
  );

  Future <void> _setData({String path, Map<String,dynamic> data}) async{
    final reference =Firestore.instance.document(path);
    print('$path:$data');
    await reference.setData(data);
  }
}