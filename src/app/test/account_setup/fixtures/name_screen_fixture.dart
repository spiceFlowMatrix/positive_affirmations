import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/sign_up_flow.dart';
import 'package:app/positive_affirmations_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class NameScreenFixture extends StatelessWidget {
  const NameScreenFixture({
    this.signUpBloc,
    required this.userRepository,
  });

  final SignUpBloc? signUpBloc;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          if (signUpBloc != null)
            BlocProvider<SignUpBloc>.value(value: signUpBloc!),
        ],
        child: MaterialApp(
          initialRoute: SignUpFlow.routeName,
          routes: PositiveAffirmationsRoutes().routes(context),
        ),
      ),
    );
  }
}
