import 'package:app/app_account/blocs/authentication/authentication_bloc.dart';
import 'package:app/app_account/blocs/sign_in/sign_in_cubit.dart';
import 'package:app/consts.dart';
import 'package:app/models/email_field.dart';
import 'package:app/models/password_field.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Logo(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Text(
                'Positive Affirmations',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              _Form(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              _EmailField(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              _PasswordField(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              if (state.status == FormzStatus.submissionFailure)
                Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              const _SubmitButton(),
              const Divider(
                height: 30,
                thickness: 1.5,
              ),
              Text(
                'No account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.82),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const _SignUpButton(),
            ],
          ),
        );
      },
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const FittedBox(
        fit: BoxFit.fill,
        child: Image(image: AssetImage('assets/images/pa_logo.png')),
      ),
    );
  }
}

class _EmailField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<_EmailField> {
  TextEditingController _controller = TextEditingController();

  String _generateErrorText(EmailFieldValidationError error) {
    switch (error) {
      case EmailFieldValidationError.empty:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
      case EmailFieldValidationError.invalid_email:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
    }
  }

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<SignInCubit>().state.email.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<SignInCubit>().emailUpdated(email),
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: state.email.invalid
                ? _generateErrorText(state.email.error!)
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  TextEditingController _controller = TextEditingController();

  String _generateErrorText(PasswordFieldValidationError error) {
    switch (error) {
      case PasswordFieldValidationError.empty:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
      case PasswordFieldValidationError.invalid_password:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
    }
  }

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<SignInCubit>().state.password.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignInCubit>().passwordUpdated(password),
          keyboardType: TextInputType.visiblePassword,
          controller: _controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid
                ? _generateErrorText(state.password.error!)
                : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () {
                  context.read<SignInCubit>().logInWithCredentials();
                }
              : null,
          child: const Text('Sign in'),
        );
      },
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
