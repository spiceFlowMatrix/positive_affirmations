import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/name_form.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:app/positive_affirmations_routes.dart';
import 'package:repository/repository.dart';

class NameFormFixture extends StatelessWidget {
  NameFormFixture(this.bloc,
      {required this.userRepository, this.navigatorObserver, this.authBloc});

  final SignUpBloc bloc;
  final UserRepository userRepository;
  final AuthenticationBloc? authBloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: MultiBlocProvider(
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
          navigatorObservers: [
            if (navigatorObserver != null) navigatorObserver!
          ],
        ),
      ),
    );
  }
}
