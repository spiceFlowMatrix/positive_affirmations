import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/app_summary_screen.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';

class AppSummaryScreenFixture extends StatelessWidget {
  const AppSummaryScreenFixture(
    this.bloc, {
    this.authBloc,
    required this.profileBloc,
  });

  final SignUpBloc bloc;
  final ProfileBloc profileBloc;
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

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authBloc!),
        BlocProvider<ProfileBloc>.value(value: profileBloc),
      ],
      child: app,
    );
  }
}
