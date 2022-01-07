import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account_setup/bloc/sign_up/sign_up_cubit.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';
import 'package:positive_affirmations/common/widgets/already_have_account_content.dart';
import 'package:positive_affirmations/consts.dart';

class NameFormScreen extends StatelessWidget {
  const NameFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: PositiveAffirmationsKeys.nameFormScreen,
      body: _NameForm(),
    );
  }
}

class _NameForm extends StatelessWidget {
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
              _NameField(),
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
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
        children: const [
          TextSpan(
            text: 'Hi. My name\'s Buddy\n',
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(text: 'What\'s your name?'),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);

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
    final cubit = context.read<SignUpCubit>();
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: cubit.state.name.value,
          onChanged: (name) => context.read<SignUpCubit>().updateName(name),
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
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.nameStatus.isValidated
              ? () {
                  context.read<SignUpCubit>().submitName();
                }
              : null,
          child: const Text('NEXT'),
        );
      },
    );
  }
}
