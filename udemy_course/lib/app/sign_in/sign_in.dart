import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/app/sign_in/email_sign_in_page.dart';
import 'package:udemy_course/app/sign_in/sign_in_bloc.dart';
import 'package:udemy_course/app/sign_in/sign_in_button.dart';
import 'package:udemy_course/app/sign_in/social_sign_in_button.dart';
import 'package:udemy_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:udemy_course/services/auth.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;
  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      dispose: (context,bloc)=>bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInErrors(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInErrors(context, e);
      }
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInErrors(context, e);
      }
    } finally {
      bloc.setIsLoading(false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  void _showSignInErrors(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign In Fail',
      exception: exception,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _headerWidgetBuilder(isLoading),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: 'Sign In with Google',
            assetName: 'images/google-logo.png',
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
            textColor: Colors.black87,
            height: 40.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign In with Facebook',
            color: Color(0xFF334D92),
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
            textColor: Colors.white,
            height: 40.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign In with Email',
            color: Colors.teal[700],
            onPressed: isLoading ? null : () => _signInWithEmail(context),
            textColor: Colors.white,
            height: 40.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign In Anonymous',
            color: Colors.lime[300],
            onPressed: isLoading ? null : () => _signInAnonymously(context),
            textColor: Colors.black,
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _headerWidgetBuilder(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text(
        'Sign In',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}
