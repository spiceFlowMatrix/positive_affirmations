import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AppSummaryScreenArguments {
  AppSummaryScreenArguments(this.bloc);

  final SignUpBloc bloc;
}

class AppSummaryScreen extends StatelessWidget {
  static const routeName = '/appSummaryScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args =
        ModalRoute.of(context)!.settings.arguments as AppSummaryScreenArguments;

    return BlocProvider.value(
      value: args.bloc,
      child: Scaffold(
        key: PositiveAffirmationsKeys.appSummaryScreen,
        body: _AppSummary(),
      ),
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(),
        _ScreenControls(),
      ],
    );
  }
}

class _ScreenControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        FontAwesomeIcons.chevronLeft,
        key: PositiveAffirmationsKeys.changeNickNameButton,
      ),
      trailing: TextButton(
        onPressed: () {},
        child: Text('SKIP'),
      ),
    );
  }
}
