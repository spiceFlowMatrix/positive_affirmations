import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(),
        _ScreenControls(),
        _UserNameHeader(),
        Text(
          'Allow me to explain what I can do for you.',
          key: PositiveAffirmationsKeys.appSummaryHeader,
          textAlign: TextAlign.left,
          style: PositiveAffirmationsTheme.theme.textTheme.headline1?.copyWith(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          'You can skip this at any time if you\'re getting bored though.',
          key: PositiveAffirmationsKeys.appSummarySubheader,
        ),
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

class _UserNameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return RichText(
          key: PositiveAffirmationsKeys.appSummaryUserNameHeader,
          text: TextSpan(
            style:
                PositiveAffirmationsTheme.theme.textTheme.headline1?.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: 'Alright, '),
              TextSpan(
                text:
                    '${state.nickName.value.isNotEmpty ? state.nickName.value : state.name.value}',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
