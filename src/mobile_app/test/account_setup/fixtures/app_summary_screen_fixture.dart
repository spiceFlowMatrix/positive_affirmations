import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/app_summary_screen.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';

class AppSummaryScreenFixture extends StatelessWidget {
  const AppSummaryScreenFixture(
    this.bloc, {
    this.authBloc,
  });

  final SignUpBloc bloc;
  final AuthenticationBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
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
    if (authBloc == null) return app;

    return BlocProvider<AuthenticationBloc>.value(
      value: authBloc!,
      child: app,
    );
  }
}
