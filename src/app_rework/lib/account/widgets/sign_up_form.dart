import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/account/widgets/sign_in_form.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_email_form_field.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_nullable_person_name_field.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_password_field.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_person_name_field.dart';
import 'package:positive_affirmations/theme.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _NameField(),
            _NickNameField(),
            _EmailField(),
            _PasswordField(),
            _ConfirmPasswordField(),
            _SubmitButton(),
            _AlreadyHaveAccountPanel(),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatefulWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CommonPersonNameField(
          key: const Key('__signUpForm_nameInput_textField__'),
          name: state.name,
          onChanged: (value) => cubit.updateName(value),
        );
      },
    );
  }
}

class _NickNameField extends StatelessWidget {
  const _NickNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.nickName != current.nickName,
      builder: (context, state) {
        return CommonNullablePersonNameField(
          key: const Key('__signUpForm_nickNameInput_textField__'),
          name: state.nickName,
          onChanged: (value) => cubit.updateNickname(value),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CommonEmailFormField(
          key: const Key('__signUpForm_emailInput_textField__'),
          email: state.email,
          onChanged: (value) => cubit.updateEmail(value),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();

    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CommonPasswordField(
          key: const Key('__signUpForm_passwordInput_textField__'),
          password: state.password,
          onChanged: (value) => cubit.updatePassword(value),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();

    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.password != current.password,
      builder: (context, state) {
        return CommonPasswordField(
          key: const Key('__signUpForm_confirmPasswordInput_textField__'),
          password: state.confirmPassword,
          confirmingPassword: state.password,
          onChanged: (value) => cubit.updateConfirmPassword(value),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  Widget get _loadingIndicator {
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildButton(BuildContext context, SignUpFormState state) {
    return ElevatedButton(
      key: const Key('__signUpForm_submit_button__'),
      onPressed: state.status.isValidated && state.passwordConfirmed
          ? () => context.read<SignUpFormCubit>().submit()
          : null,
      child: const Text(
        'SIGN UP',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CommonFormPadding(
          verticalPadding: 12,
          child: state.status.isSubmissionInProgress
              ? _loadingIndicator
              : _buildButton(context, state),
        );
      },
    );
  }
}

class _AlreadyHaveAccountPanel extends StatelessWidget {
  const _AlreadyHaveAccountPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonFormPadding(
      verticalPadding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Divider(
            height: 30,
            thickness: 1.5,
          ),
          Text(
            'Already have an account?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          _AlreadyHaveAccountSignInButton(),
        ],
      ),
    );
  }
}

class _AlreadyHaveAccountSignInButton extends StatelessWidget {
  const _AlreadyHaveAccountSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: const Key('__signUpForm_signIn_button__'),
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          SignInForm.routeName,
        );
      },
      child: const Text(
        'SIGN IN',
      ),
      style: OutlinedButton.styleFrom(
        primary: AppTheme.secondaryColor,
        side: const BorderSide(color: AppTheme.secondaryColor),
      ),
    );
  }
}
