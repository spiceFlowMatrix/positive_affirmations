import 'package:app/app_account/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:app/positive_affirmations_routes.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';

class AffirmationsHomeScreenFixture extends StatelessWidget {
  AffirmationsHomeScreenFixture({
    required this.apptabBloc,
    required this.authBloc,
    required this.profileBloc,
    this.affirmationsBloc,
    this.navigatorObserver,
  });

  final ApptabBloc apptabBloc;
  final AuthenticationBloc authBloc;
  final ProfileBloc profileBloc;
  final AffirmationsBloc? affirmationsBloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: profileBloc),
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
