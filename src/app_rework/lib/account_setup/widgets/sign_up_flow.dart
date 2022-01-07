import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account_setup/bloc/sign_up/sign_up_cubit.dart';
import 'package:positive_affirmations/account_setup/widgets/name_form_screen.dart';

class SignUpFlow extends StatelessWidget {
  const SignUpFlow({Key? key}) : super(key: key);
  static const String routeName = '/signUpFlow';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(),
      child: _Flow(),
    );
  }
}

class _Flow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SignUpState>(
      state: context.select((SignUpCubit bloc) => bloc.state),
      onGeneratePages: (state, pages) {
        return [
          const MaterialPage(child: NameFormScreen()),
          // if (state.nameStatus == FormzStatus.submissionSuccess)
          //   const MaterialPage(child: NickNameFormScreen()),
          // if (state.nameStatus == FormzStatus.submissionSuccess &&
          //     state.nickNameStatus == FormzStatus.submissionSuccess)
          //   const MaterialPage(child: AccountDetailsForm())
        ];
      },
    );
  }
}
