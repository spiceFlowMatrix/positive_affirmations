import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/already_have_account_content.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: const [
              _Label(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _EmailField(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _PasswordField(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _ConfirmPasswordField(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _SubmitButton(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _BackButton(),
              AlreadyHaveAccountPanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: PositiveAffirmationsKeys.nameFieldLabel,
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

class _EmailField extends StatelessWidget {
  const _EmailField();

  String _generateErrorText(EmailFieldValidationError error) {
    switch (error) {
      case EmailFieldValidationError.empty:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
      case EmailFieldValidationError.invalid_email:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.nameField,
          onChanged: (email) =>
              context.read<SignUpBloc>().add(EmailUpdated(email: email)),
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

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  String _generateErrorText(PasswordFieldValidationError error) {
    switch (error) {
      case PasswordFieldValidationError.empty:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
      case PasswordFieldValidationError.invalid_password:
        return PositiveAffirmationsConsts.invalidEmailErrorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.nameField,
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(PasswordUpdated(password: password)),
          keyboardType: TextInputType.visiblePassword,
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

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.nameField,
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(ConfirmPasswordUpdated(confirmPassword: password)),
          keyboardType: TextInputType.visiblePassword,
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          key: PositiveAffirmationsKeys.nameSubmitButton,
          onPressed: state.emailStatus.isValidated &&
                  state.emailStatus != FormzStatus.pure &&
                  state.passwordStatus.isValidated &&
                  state.confirmPasswordStatus.isValidated
              ? () {
                  context.read<SignUpBloc>().add(AccountDetailsSubmitted());
                }
              : null,
          child: const Text('Done'),
        );
      },
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: PositiveAffirmationsKeys.changeNameButton,
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('BACK'),
    );
  }
}
