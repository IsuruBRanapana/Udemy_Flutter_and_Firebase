import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/app/sign_in/email_sign_in_bloc.dart';
import 'package:udemy_course/app/sign_in/email_signin_change_model.dart';
import 'package:udemy_course/app/sign_in/email_signin_model.dart';
import 'package:udemy_course/app/sign_in/validator.dart';
import 'package:udemy_course/common_widgets/form_submit_buttons.dart';
import 'package:udemy_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:flutter/services.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => EmailSignInFormChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInChangeModel get model =>widget.model;

  void _toogleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _gotoPasswordEditing() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {

    try {
      await model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in Failed',
        exception: e,
      ).show(context);
    }
  }

  List<Widget> _buildChildren() {
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
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: model.isLoading ? null :()=> _toogleFormType(),
      ),
    ];
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged:model.updatePassword,
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
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged:model.updateEmail,
      onEditingComplete: ()=>_gotoPasswordEditing(),
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
