import 'package:app/app_account/blocs/authentication/authentication_bloc.dart';
import 'package:app/app_account/blocs/sign_in/sign_in_cubit.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = '/signInScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(context.read<UserRepository>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SignUpButton(),
            ],
          ),
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
