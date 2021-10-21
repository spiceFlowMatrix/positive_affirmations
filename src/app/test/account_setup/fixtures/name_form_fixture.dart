import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/sign_up_flow.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class NameFormFixture extends StatelessWidget {
  const NameFormFixture(
    this.bloc, {
    Key? key,
    required this.userRepository,
    this.navigatorObserver,
    this.authBloc,
  }) : super(key: key);

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
          initialRoute: SignUpFlow.routeName,
          navigatorObservers: [
            if (navigatorObserver != null) navigatorObserver!
          ],
          onGenerateRoute: (settings) {
            final args = SignUpFlowArgs(signUpBloc: bloc);

            return MaterialPageRoute(
              builder: (context) {
                return const SignUpFlow();
              },
              settings: RouteSettings(
                name: SignUpFlow.routeName,
                arguments: args,
              ),
            );
          },
        ),
      ),
    );
  }
}
