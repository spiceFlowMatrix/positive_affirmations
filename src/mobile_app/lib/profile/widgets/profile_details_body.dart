import 'package:flutter/material.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';

class ProfileDetailsTabBody extends StatelessWidget {
  const ProfileDetailsTabBody({this.profileTabBloc})
      : super(key: PositiveAffirmationsKeys.profileDetails);

  final ProfileTabBloc? profileTabBloc;

  @override
  Widget build(BuildContext context) {
    return Text('PROFILE DETAILS BODY');
  }
}
