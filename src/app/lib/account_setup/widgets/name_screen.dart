import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({Key? key}) : super(key: key);
  static const String routeName = '/nameScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text('Name Form Screen'),
            ElevatedButton(
              onPressed: () {
                final bloc = BlocProvider.of<SignUpBloc>(context);
                bloc.add(const NameUpdated('testName'));
                bloc.add(const NameSubmitted());
                bloc.add(const NickNameUpdated('testNickname'));
                bloc.add(const NickNameSubmitted());
                bloc.add(UserSubmitted());

                final state = bloc.state;

                BlocProvider.of<ProfileBloc>(context)
                    .add(UserCreated(user: state.createdUser));
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(const AuthenticationStatusChanged(
                  status: AuthenticationStatus.authenticated,
                ));
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
