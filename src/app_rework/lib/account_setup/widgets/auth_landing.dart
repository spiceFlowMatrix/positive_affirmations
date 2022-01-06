import 'package:flutter/material.dart';
import 'package:positive_affirmations/common/widgets/already_have_account_content.dart';

class AuthLanding extends StatelessWidget {
  const AuthLanding({Key? key}) : super(key: key);

  static const String routeName = '/authLanding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SignUpPanel(),
            const AlreadyHaveAccountPanel(),
          ],
        ),
      ),
    );
  }
}

class _SignUpPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sign up with Phone Number'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUpFlow.routeName);
          },
          child: const Text('Sign up with Email'),
        ),
      ],
    );
  }
}