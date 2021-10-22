import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/already_have_account_content.dart';
import 'package:app/consts.dart';
import 'package:app/models/models.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/positive_affirmations_theme.dart';
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
              _SubmitButton(),
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
      text: TextSpan(
        style: PositiveAffirmationsTheme.theme.textTheme.headline1?.copyWith(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        children: const [
          TextSpan(
            text: 'And finally\n',
            style: TextStyle(color: Colors.grey),
          ),
          // TextSpan(text: 'What\'s your name?'),
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  String _generateErrorText(NameFieldValidationError error) {
    switch (error) {
      case NameFieldValidationError.empty:
        return PositiveAffirmationsConsts.nameFieldEmptyError;
      case NameFieldValidationError.invalid:
        return PositiveAffirmationsConsts.nameFieldInvalidError;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          key: PositiveAffirmationsKeys.nameField,
          onChanged: (name) =>
              context.read<SignUpBloc>().add(NameUpdated(name)),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid
                ? _generateErrorText(state.name.error!)
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          key: PositiveAffirmationsKeys.nameSubmitButton,
          onPressed: state.nameStatus.isValidated
              ? () {
                  context.read<SignUpBloc>().add(const NameSubmitted());
                }
              : null,
          child: const Text('NEXT'),
        );
      },
    );
  }
}
