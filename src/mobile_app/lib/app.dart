import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_routes.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
        BlocProvider<ApptabBloc>(create: (_) => ApptabBloc()),
      ],
      child: AppView(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: PositiveAffirmationsTheme.theme,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
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
                  NameFormScreen.routeName,
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
      initialRoute: NameFormScreen.routeName,
      routes: PositiveAffirmationsRoutes().routes(context),
    );
  }
}
