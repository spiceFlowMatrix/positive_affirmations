import 'package:flutter/material.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/app_summary_screen.dart';

class AppSummaryScreenFixture extends StatelessWidget {
  const AppSummaryScreenFixture(this.bloc);

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // if (settings.name == AppSummaryScreen.routeName) {
        //
        // }

        final args = AppSummaryScreenArguments(bloc);

        return MaterialPageRoute(
          builder: (context) {
            return AppSummaryScreen();
          },
          settings: RouteSettings(
            name: AppSummaryScreen.routeName,
            arguments: args,
          ),
        );
      },
      initialRoute: AppSummaryScreen.routeName,
      // Removed routes definition because it conflicts with onGenerateRoute
      // routes: PositiveAffirmationsRoutes().routes(context),
    );
  }
}
