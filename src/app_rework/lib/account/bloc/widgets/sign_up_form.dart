import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  static const String routeName = '/signUpForm';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpFormCubit>(
      create: (_) => SignUpFormCubit(),
      child: const Scaffold(
        body: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            _NameField(),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return CommonFormPadding(
      child: TextFormField(
        initialValue: cubit.state.name.value,
        onChanged: (value) => cubit.updateName(value),
        decoration: const InputDecoration(
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          labelText: 'Name',
        ),
      ),
    );
  }
}
