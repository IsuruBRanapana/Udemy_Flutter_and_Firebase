enum EmailSignInFormType { signIn, Register }

class EmailSignInModel {
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
}
