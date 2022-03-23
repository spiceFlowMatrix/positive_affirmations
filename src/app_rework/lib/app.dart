import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account/bloc/widgets/sign_up_form.dart';
import 'package:positive_affirmations/common/blocs/app/app_bloc.dart';
import 'package:positive_affirmations/home/widgets/home_screen.dart';
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
          BlocProvider<AppBloc>(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          theme: AppTheme.theme,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AppBloc, AppState>(
              listener: (context, state) {
                switch (state.status) {
                  case AppStatus.authenticated:
                    if (_navigator.widget.initialRoute !=
                        HomeScreen.routeName) {
                      _navigator.pushNamedAndRemoveUntil(
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    }
                    break;
                  case AppStatus.unauthenticated:
                    if (_navigator.widget.initialRoute !=
                        SignUpForm.routeName) {
                      _navigator.pushNamedAndRemoveUntil(
                        SignUpForm.routeName,
                        (route) => false,
                      );
                    }
                    break;
                }
              },
              child: child,
            );
          },
          initialRoute: state.status == AppStatus.unauthenticated
              ? SignUpForm.routeName
              : HomeScreen.routeName,
          routes: namedRoutes(context),
        );
      },
    );
  }
}
