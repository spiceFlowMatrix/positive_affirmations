import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/name_form_screen.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class SignUpFlowArgs {
  const SignUpFlowArgs({this.signUpBloc});

  final SignUpBloc? signUpBloc;
}

class SignUpFlow extends StatelessWidget {
  const SignUpFlow({Key? key}) : super(key: key);
  static const String routeName = '/signUpFlow';

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository =
        RepositoryProvider.of<UserRepository>(context);

    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as SignUpFlowArgs?;

    if (args != null && args.signUpBloc != null) {
      return BlocProvider<SignUpBloc>.value(
        value: args.signUpBloc!,
        child: _Flow(),
      );
    } else {
      return BlocProvider(
        create: (_) => SignUpBloc(userRepository: userRepository),
        child: _Flow(),
      );
    }
  }
}

class _Flow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SignUpState>(
      state: context.select((SignUpBloc bloc) => bloc.state),
      onGeneratePages: (state, pages) {
        return [
          const MaterialPage(child: NameFormScreen()),
        ];
      },
    );
  }
}
