import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class NickNameForm extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              RichText(
                key: PositiveAffirmationsKeys.nickNameFieldLabel,
                text: TextSpan(text: 'label'),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              _NickNameField(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              _SubmitButton(),
              const Padding(padding: EdgeInsets.only(top: 10)),
              OutlinedButton(
                key: PositiveAffirmationsKeys.changeNameButton,
                onPressed: () {},
                child: Text('BACK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NickNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: PositiveAffirmationsKeys.nickNameField,
      onChanged: (nickName) =>
          context.read<SignUpBloc>().add(NickNameUpdated(nickName)),
      decoration: InputDecoration(
        labelText: 'Nickname',
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          key: PositiveAffirmationsKeys.nickNameSubmitButton,
          onPressed:
              state.nickNameStatus.isValidated || state.nickNameStatus.isPure
                  ? () => context.read<SignUpBloc>().add(NickNameSubmitted())
                  : null,
          child: Text('NEXT'),
        );
      },
    );
  }
}
