import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/common_widgets/form_submit_buttons.dart';
import 'package:udemy_course/services/auth.dart';

enum EmailSignInFormType { signIn, Register }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;


  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  void _toogleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.Register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _gotoPasswordEditing(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _updateState(){
    setState(() {});
  }

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account ? Register'
        : 'Have an Account ? Log in';

    bool submitEnable = _email.isNotEmpty&&_password.isNotEmpty;
    return [
      _buildEmailField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButtons(
        text: primaryText,
        onPressed: submitEnable?_submit:null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _toogleFormType,
      ),
    ];
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password)=>_updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email)=>_updateState(),
      onEditingComplete: _gotoPasswordEditing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
