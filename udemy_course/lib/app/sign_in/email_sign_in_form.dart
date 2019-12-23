import 'package:flutter/material.dart';
import 'package:udemy_course/common_widgets/form_submit_buttons.dart';

enum EmailSignInFormType{signIn,Register}
class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  void _toogleFormType(){
    setState(() {
      _formType = _formType==EmailSignInFormType.signIn ?
          EmailSignInFormType.Register : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }
  void _submit(){

  }

  List<Widget> _buildChildren() {

    final primaryText = _formType==EmailSignInFormType.signIn ?
        'Sign In':'Create an Account';

    final secondaryText=_formType==EmailSignInFormType.signIn ?
        'Need an Account ? Register':'Have an Account ? Log in';
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButtons(
        text:primaryText,
        onPressed: _submit,
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
