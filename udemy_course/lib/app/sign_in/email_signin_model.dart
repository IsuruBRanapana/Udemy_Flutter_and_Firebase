import 'package:udemy_course/app/sign_in/validator.dart';

enum EmailSignInFormType { signIn, Register }

class EmailSignInModel with EmailAndPasswordValidators{
  EmailSignInModel({
    this.email: '',
    this.password: '',
    this.formType: EmailSignInFormType.signIn,
    this.isLoading: false,
    this.submitted: false,
  });
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';
  }

  String get secondaryButtonText{
    return formType == EmailSignInFormType.signIn
        ? 'Need an Account ? Register'
        : 'Have an Account ? Log in';
  }

  bool get canSubmit{
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText{
    bool showErrorPassword =
        submitted && !passwordValidator.isValid(password);
    return showErrorPassword ? errorTextPassword  : null;
  }

  String get emailErrorText{
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? errorTextEmail  : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
