import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
              // const _Label(),
              // const Padding(padding: EdgeInsets.only(top: 10)),
              // _NameField(),
              // const Padding(padding: EdgeInsets.only(top: 10)),
              // const _SubmitButton(),
              // const AlreadyHaveAccountPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
