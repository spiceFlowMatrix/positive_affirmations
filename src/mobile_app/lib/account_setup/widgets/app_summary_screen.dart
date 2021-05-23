import 'package:flutter/material.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';

class AppSummaryScreenArguments {
  AppSummaryScreenArguments(this.bloc);

  final SignUpBloc bloc;
}

class AppSummaryScreen extends StatelessWidget {
  static const routeName = '/appSummaryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AppSummary(),
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('App summary screen'));
  }
}
