import 'package:flutter/foundation.dart';
import 'package:udemy_course/app/sign_in/email_signin_model.dart';
import 'package:udemy_course/app/sign_in/validator.dart';
import 'package:udemy_course/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email: '',
    this.password: '',
    this.formType: EmailSignInFormType.signIn,
    this.isLoading: false,
    this.submitted: false,
  });

  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(isLoading: true,submitted: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an Account ? Register'
        : 'Have an Account ? Log in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorPassword = submitted && !passwordValidator.isValid(password);
    return showErrorPassword ? errorTextPassword : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? errorTextEmail : null;
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
  void toggleFormType(){
    final formType=this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.Register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: formType,
      isLoading: false,
    );
  }

  void updatePassword(String password) => updateWith(password: password);

  void updateEmail(String email) => updateWith(email: email);

}
