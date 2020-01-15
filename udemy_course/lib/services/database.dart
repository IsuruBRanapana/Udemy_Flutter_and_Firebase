import 'package:flutter/foundation.dart';

abstract class Database{

}

class FirestoreDatabase extends Database{
  FirestoreDatabase({@required this.uid}): assert(uid != null);
  final String uid;
}