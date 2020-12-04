import 'package:flutter/material.dart';

class SignInFacebook extends StatelessWidget {
  const SignInFacebook({Key key, @required this.facebookSignIn})
      : super(key: key);
  final facebookSignIn;

  // Future<void> _handleSignOut() async {
  //   await facebookSignIn.logOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with Facebook'),
      ),
      // body: Center(
      //   child: RaisedButton(
      //     child: const Text('SIGN OUT'),
      //     onPressed: _handleSignOut,
      //   ),
      // ),
    );
  }
}
