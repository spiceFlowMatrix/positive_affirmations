import 'package:app/account_setup/widgets/name_form_screen.dart';
import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:app/positive_affirmations_routes.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
    this.profileBloc,
  }) : super(key: key);

  final UserRepository userRepository;
  final ProfileBloc? profileBloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          if (profileBloc != null)
            BlocProvider<ProfileBloc>(create: (_) => profileBloc!)
          else
            BlocProvider<ProfileBloc>(create: (_) => HydratedProfileBloc()),
          BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
          BlocProvider<ApptabBloc>(create: (_) => ApptabBloc()),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Widget _buildMainApp() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: PositiveAffirmationsTheme.theme,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                print(state.status.toString());
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    _navigator.pushNamedAndRemoveUntil(
                      NameFormScreen.routeName,
                      (route) => false,
                    );
                    // _navigator.pushAndRemoveUntil(
                    //   NameFormScreen.route(),
                    //   (route) => false,
                    // );
                    break;
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AffirmationsHomeScreen.routeName,
                      (route) => false,
                    );
                    // _navigator.pushAndRemoveUntil(
                    //   NameFormScreen.route(),
                    //   (route) => false,
                    // );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      NameFormScreen.routeName,
                      (route) => false,
                    );
                    // _navigator.pushAndRemoveUntil(
                    //   NameFormScreen.route(),
                    //   (route) => false,
                    // );
                    break;
                }
              },
              child: child,
            );
          },
          // onGenerateRoute: (_) => NameFormScreen.route(),
          // routes: {
          //   NickNameFormScreen.routeName: (context) => NickNameFormScreen(),
          // },
          initialRoute: state.status == AuthenticationStatus.authenticated
              ? AffirmationsHomeScreen.routeName
              : NameFormScreen.routeName,
          routes: PositiveAffirmationsRoutes().routes(context),
        );
      },
    );
  }

  Widget _buildError() {
    return MaterialApp(
      theme: PositiveAffirmationsTheme.theme,
      home: const Scaffold(
        body: Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return MaterialApp(
      theme: PositiveAffirmationsTheme.theme,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildError();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildMainApp();
        }
        return _buildLoading();
      },
    );
  }
}
