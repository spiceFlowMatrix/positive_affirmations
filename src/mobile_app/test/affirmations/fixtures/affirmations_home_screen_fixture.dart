import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_routes.dart';

class AffirmationsHomeScreenFixture extends StatelessWidget {
  AffirmationsHomeScreenFixture({
    required this.apptabBloc,
    required this.authBloc,
    this.affirmationsBloc,
    this.navigatorObserver,
  });

  final ApptabBloc apptabBloc;
  final AuthenticationBloc authBloc;
  final AffirmationsBloc? affirmationsBloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
        BlocProvider<ApptabBloc>.value(value: apptabBloc),
      ],
      child: MaterialApp(
        home: AffirmationsHomeScreen(
          affirmationsBloc: affirmationsBloc,
        ),
        // initialRoute: NameFormScreen.routeName,
        routes: PositiveAffirmationsRoutes().routes(context),
        navigatorObservers: [if (navigatorObserver != null) navigatorObserver!],
      ),
    );
  }
}
