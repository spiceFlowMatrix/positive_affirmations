import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account_setup/widgets/auth_landing.dart';
import 'package:positive_affirmations/common/bloc/auth/auth_bloc.dart';
import 'package:positive_affirmations/common/widgets/home_scaffold.dart';
import 'package:positive_affirmations/named_routes.dart';
import 'package:positive_affirmations/theme.dart';
import 'package:repository/repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required ApiClient apiClient,
  })  : _authenticationRepository = authenticationRepository,
        _apiClient = apiClient,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final ApiClient _apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<ApiClient>.value(
          value: _apiClient,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

// Note: This must be a stateful widget in order to avoid resetting navigation on hot reloads
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return MaterialApp(
          theme: AppTheme.theme,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.authenticated:
                    if (_navigator.widget.initialRoute !=
                        HomeScaffold.routeName) {
                      _navigator.pushNamedAndRemoveUntil(
                        HomeScaffold.routeName,
                        (route) => false,
                      );
                    }
                    break;
                  case AuthStatus.unauthenticated:
                    if (_navigator.widget.initialRoute !=
                        AuthLanding.routeName) {
                      _navigator.pushNamedAndRemoveUntil(
                        AuthLanding.routeName,
                        (route) => false,
                      );
                    }
                    break;
                }
              },
              child: child,
            );
          },
          initialRoute: state.status == AuthStatus.unauthenticated
              ? AuthLanding.routeName
              : HomeScaffold.routeName,
          routes: namedRoutes(context),
        );
      },
    );
  }
}
