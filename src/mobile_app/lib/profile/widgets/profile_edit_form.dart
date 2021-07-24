import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';

class ProfileEditFormArgs {
  const ProfileEditFormArgs({
    required this.profileBloc,
    this.profileEditBloc,
  });

  final ProfileBloc profileBloc;
  final ProfileEditBloc? profileEditBloc;
}

class ProfileEditForm extends StatelessWidget {
  static const String routeName = '/profileEditForm';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfileEditFormArgs;

    final profileEditBloc = args.profileEditBloc == null
        ? BlocProvider(
            create: (_) => ProfileEditBloc(
              profileBloc: args.profileBloc,
            ),
          )
        : BlocProvider<ProfileEditBloc>.value(value: args.profileEditBloc!);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: args.profileBloc),
        profileEditBloc,
      ],
      child: Scaffold(
        key: PositiveAffirmationsKeys.profileEditScreen,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            key: PositiveAffirmationsKeys.profileEditScreenTitle,
          ),
        ),
        body: Center(
          child: Text('Profile edit form'),
        ),
      ),
    );
  }
}
