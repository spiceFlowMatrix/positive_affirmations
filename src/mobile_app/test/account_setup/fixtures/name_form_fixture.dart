import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/name_form.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_routes.dart';

class NameFormFixture extends StatelessWidget {
  NameFormFixture(this.bloc, {this.navigatorObserver, this.authBloc});

  final SignUpBloc bloc;
  final AuthenticationBloc? authBloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (authBloc != null)
          BlocProvider<AuthenticationBloc>.value(value: authBloc!),
        BlocProvider<SignUpBloc>.value(value: bloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: NameForm(),
        ),
        // initialRoute: NameFormScreen.routeName,
        routes: PositiveAffirmationsRoutes().routes(context),
        navigatorObservers: [if (navigatorObserver != null) navigatorObserver!],
      ),
    );
  }
}
