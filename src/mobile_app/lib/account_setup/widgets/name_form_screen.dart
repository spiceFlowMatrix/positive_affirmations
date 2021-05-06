import 'package:flutter/material.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/name_form.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameFormScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NameFormScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        key: PositiveAffirmationsKeys.nameFormScreen,
        body: NameForm(),
      ),
    );
  }
}
