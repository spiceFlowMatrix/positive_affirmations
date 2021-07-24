import 'package:flutter/material.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:mobile_app/profile/widgets/profile_edit_form.dart';

class ProfileEditFormFixture extends StatelessWidget {
  ProfileEditFormFixture({
    required this.profileBloc,
    required this.profileEditBloc,
  });

  final ProfileBloc profileBloc;
  final ProfileEditBloc profileEditBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = ProfileEditFormArgs(
          profileBloc: profileBloc,
          profileEditBloc: profileEditBloc,
        );

        return MaterialPageRoute(
          builder: (context) {
            return ProfileEditForm();
          },
          settings: RouteSettings(
            name: ProfileEditForm.routeName,
            arguments: args,
          ),
        );
      },
      initialRoute: ProfileEditForm.routeName,
    );
  }
}
