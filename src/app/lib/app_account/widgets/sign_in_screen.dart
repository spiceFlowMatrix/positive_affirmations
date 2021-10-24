import 'package:app/app_account/blocs/authentication/authentication_bloc.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = '/signInScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context
            .read<AuthenticationBloc>()
            .add(const AuthenticationStatusChanged(
              status: AuthenticationStatus.unknown,
            ));
      },
      child: const Text(
        'Sign up',
      ),
      style: OutlinedButton.styleFrom(
        primary: PositiveAffirmationsTheme.highlightColor,
        side: BorderSide(color: PositiveAffirmationsTheme.highlightColor),
      ),
    );
  }
}
