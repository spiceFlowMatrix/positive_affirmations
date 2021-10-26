import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:app/app_account/blocs/authentication/authentication_bloc.dart';
import 'package:app/app_account/widgets/sign_in_screen.dart';
import 'package:app/app_account/widgets/widgets.dart';
import 'package:app/positive_affirmations_routes.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
    required this.affirmationsRepository,
    this.profileBloc,
  }) : super(key: key);

  final UserRepository userRepository;
  final AffirmationsRepository affirmationsRepository;
  final ProfileBloc? profileBloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<AffirmationsRepository>.value(
            value: affirmationsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          if (profileBloc != null)
            BlocProvider<ProfileBloc>(create: (_) => profileBloc!)
          else
            BlocProvider<ProfileBloc>(
                create: (_) =>
                    HydratedProfileBloc(userRepository: userRepository)),
          BlocProvider<AuthenticationBloc>(
              create: (_) =>
                  AuthenticationBloc(userRepository: userRepository)),
          BlocProvider<ApptabBloc>(create: (_) => ApptabBloc()),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: PositiveAffirmationsTheme.theme,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              // listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    _navigator.pushNamedAndRemoveUntil(
                      SignUpFlow.routeName,
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AffirmationsHomeScreen.routeName,
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      SignInScreen.routeName,
                      (route) => false,
                    );
                    break;
                }
              },
              child: child,
            );
          },
          initialRoute: state.status == AuthenticationStatus.authenticated
              ? AffirmationsHomeScreen.routeName
              : SignUpFlow.routeName,
          routes: PositiveAffirmationsRoutes().routes(context),
        );
      },
    );
  }
}
