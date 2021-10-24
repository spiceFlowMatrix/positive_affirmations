import 'package:app/app_account/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/app_account/widgets/already_have_account_content.dart';
import 'package:app/consts.dart';
import 'package:app/models/email_field.dart';
import 'package:app/models/password_field.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AccountDetailsForm extends StatelessWidget {
  const AccountDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PositiveAffirmationsKeys.nameFormScreen,
      body: _Form(),
    );
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const _Label(),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  _EmailField(),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  _PasswordField(),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  _ConfirmPasswordField(),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  if (state.submissionStatus == FormzStatus.submissionFailure)
                    Text(
                      state.submissionError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const _SubmitButton(),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const _BackButton(),
                  const AlreadyHaveAccountPanel(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: PositiveAffirmationsKeys.accountDetailsFormHeader,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'And finally\n',
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextSpan(
            text:
                'To give you access to all features, I\'d need your email address and for you to set a strong password to your public account.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
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
        text: context.read<SignUpBloc>().state.email.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.accountDetailsEmailField,
          onChanged: (email) =>
              context.read<SignUpBloc>().add(EmailUpdated(email: email)),
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
        text: context.read<SignUpBloc>().state.password.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.accountDetailsPasswordField,
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(PasswordUpdated(password: password)),
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

class _ConfirmPasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<_ConfirmPasswordField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<SignUpBloc>().state.confirmPassword.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.accountDetailsConfirmPasswordField,
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(ConfirmPasswordUpdated(confirmPassword: password)),
          keyboardType: TextInputType.visiblePassword,
          controller: _controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            errorText:
                state.confirmPassword.invalid ? 'Passwords do not match' : null,
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
    return BlocListener<SignUpBloc, SignUpState>(
      listenWhen: (previous, current) =>
          current.submissionStatus == FormzStatus.submissionSuccess &&
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        // context.read<ProfileBloc>().add(UserCreated(user: state.createdUser));
        // context.read<AuthenticationBloc>().add(
        //       const AuthenticationStatusChanged(
        //           status: AuthenticationStatus.authenticated),
        //     );
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return ElevatedButton(
            key: PositiveAffirmationsKeys.accountDetailsSubmitButton,
            onPressed: state.emailStatus.isValidated &&
                    state.emailStatus != FormzStatus.pure &&
                    state.passwordStatus.isValidated &&
                    state.confirmPasswordStatus.isValidated
                ? () {
                    context
                        .read<SignUpBloc>()
                        .add(const AccountDetailsSubmitted());
                  }
                : null,
            child: const Text('Done'),
          );
        },
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: PositiveAffirmationsKeys.accountDetailsBackButton,
      onPressed: () =>
          context.read<SignUpBloc>().add(const AccountDetailsBacked()),
      child: const Text('BACK'),
    );
  }
}
