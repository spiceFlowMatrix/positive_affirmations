import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';
import 'package:mobile_app/profile/widgets/profile_details_body.dart';

class ProfileDetailsBodyFixture extends StatelessWidget {
  const ProfileDetailsBodyFixture({
    required this.affirmationsBloc,
    required this.authBloc,
    this.profileTabBloc,
  });

  final AffirmationsBloc affirmationsBloc;
  final AuthenticationBloc authBloc;
  final ProfileTabBloc? profileTabBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AffirmationsBloc>.value(value: affirmationsBloc),
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ProfileDetailsTabBody(
            profileTabBloc: profileTabBloc,
          ),
        ),
      ),
    );
  }
}
