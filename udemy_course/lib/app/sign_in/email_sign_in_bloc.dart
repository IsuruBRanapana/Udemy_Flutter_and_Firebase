import 'dart:async';

import 'package:udemy_course/app/sign_in/email_signin_model.dart';

class EmailSignInBloc{
  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  void dispose(){
    _modelController.close();
  }
}