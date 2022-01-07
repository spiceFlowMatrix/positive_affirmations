import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account_setup/bloc/sign_up/sign_up_cubit.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';
import 'package:positive_affirmations/common/widgets/already_have_account_content.dart';
import 'package:positive_affirmations/consts.dart';
import 'package:positive_affirmations/theme.dart';

class NickNameFormScreen extends StatelessWidget {
  const NickNameFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _NickNameForm(),
    );
  }
}

class _NickNameForm extends StatelessWidget {
  _NickNameForm({Key? key}) : super(key: key);
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
              _NickNameField(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _SubmitButton(),
              Padding(padding: EdgeInsets.only(top: 10)),
              _ChangeNameButton(),
              AlreadyHaveAccountPanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
            children: [
              const TextSpan(
                text: 'Nice to meet you ',
              ),
              TextSpan(
                text: '${state.name.value}\n',
                style: const TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.secondaryColor,
                  decorationThickness: 2,
                ),
              ),
              const TextSpan(text: 'One more question.\n'),
              const TextSpan(
                text: 'What would you like me to call you? 😉',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NickNameField extends StatelessWidget {
  const _NickNameField({Key? key}) : super(key: key);

  String _generateErrorText(NickNameFieldValidationError error) {
    switch (error) {
      case NickNameFieldValidationError.invalid:
        return PositiveAffirmationsConsts.nickNameFieldInvalidError;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.nickName != current.nickName,
      builder: (context, state) {
        return TextFormField(
          initialValue: cubit.state.nickName.value,
          onChanged: (nickName) => cubit.updateNickName(nickName),
          decoration: InputDecoration(
            labelText: 'Nickname',
            errorText: state.nickName.invalid
                ? _generateErrorText(state.nickName.error!)
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
          onPressed: state.nickNameStatus.isPure ||
                  (!state.nickNameStatus.isPure &&
                      state.nickNameStatus.isValidated)
              ? () {
                  context.read<SignUpCubit>().submitNickName();
                }
              : null,
          child: const Text('NEXT'),
        );
      },
    );
  }
}

class _ChangeNameButton extends StatelessWidget {
  const _ChangeNameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.read<SignUpCubit>().backNickName(),
      child: const Text('BACK'),
    );
  }
}
