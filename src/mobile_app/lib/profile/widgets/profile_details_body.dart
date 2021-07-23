import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';
import 'package:repository/repository.dart';

class ProfileDetailsTabBody extends StatelessWidget {
  const ProfileDetailsTabBody({this.profileTabBloc})
      : super(key: PositiveAffirmationsKeys.profileDetails);

  final ProfileTabBloc? profileTabBloc;

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      children: [
        _DetailsContent(),
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

class _DetailsContent extends StatelessWidget {
  static const Padding _contentPadding =
      const Padding(padding: EdgeInsets.only(top: 10));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            _contentPadding,
            _contentPadding,
            _ProfileImage(state.user),
            _contentPadding,
            Text(
              state.user.name,
              key: PositiveAffirmationsKeys.profileName(state.user.id),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            _contentPadding,
            Text(
              state.user.nickName,
              key: PositiveAffirmationsKeys.profileNickName(state.user.id),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker _picker = ImagePicker();
        final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      },
      child: Stack(
        children: [
          CircleAvatar(
            key: PositiveAffirmationsKeys.profilePicture(user.id),
            child: user.pictureB64Enc.isEmpty ||
                    user.pictureB64Enc == User.empty.pictureB64Enc
                ? Text(
                    user.nameInitials().toUpperCase(),
                    key: PositiveAffirmationsKeys.profilePictureEmptyLabel(
                        user.id),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Image.memory(
                    Base64Decoder().convert(user.pictureB64Enc),
                    key: PositiveAffirmationsKeys.profilePictureImage(user.id),
                  ),
            radius: 36,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: FaIcon(
              FontAwesomeIcons.cameraRetro,
              size: 18,
              key: PositiveAffirmationsKeys.profilePictureCameraIndicator,
            ),
          ),
        ],
      ),
    );
  }
}
