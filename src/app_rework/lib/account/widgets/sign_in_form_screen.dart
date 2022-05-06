import 'package:flutter/material.dart';

class SignInFormScreen extends StatelessWidget {
  const SignInFormScreen({Key? key}) : super(key: key);

  static const String routeName = '/signInForm';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sign in form'),
      ),
    );
  }
}
