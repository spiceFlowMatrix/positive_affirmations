import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';
import 'package:repository/repository.dart';

class ProfileDetailsTabBody extends StatelessWidget {
  const ProfileDetailsTabBody({this.profileTabBloc})
      : super(key: PositiveAffirmationsKeys.profileDetails);

  final ProfileTabBloc? profileTabBloc;

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProfileImage(),
      ],
    );

    if (profileTabBloc != null) {
      return BlocProvider<ProfileTabBloc>.value(
        value: profileTabBloc!,
        child: content,
      );
    }

    return BlocProvider<ProfileTabBloc>(
      create: (_) => ProfileTabBloc(),
      child: content,
    );
  }
}

class _ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return CircleAvatar(
          key: PositiveAffirmationsKeys.profilePicture(state.user.id),
          child: state.user.pictureB64Enc.isEmpty ||
                  state.user.pictureB64Enc == User.empty.pictureB64Enc
              ? Text(
                  state.user.nameInitials().toUpperCase(),
                  key: PositiveAffirmationsKeys.profilePictureEmptyLabel(
                      state.user.id),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Image.memory(
                  Base64Decoder().convert(state.user.pictureB64Enc),
                  key: PositiveAffirmationsKeys.profilePictureImage(
                      state.user.id),
                ),
          radius: 36,
        );
      },
    );
  }
}
