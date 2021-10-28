import 'dart:convert';
import 'dart:typed_data';

import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:app/profile/blocs/profile_tab/profile_tab_bloc.dart';
import 'package:app/profile/widgets/profile_affirmations_tab.dart';
import 'package:app/profile/widgets/profile_letters_tab.dart';
import 'package:app/profile/widgets/profile_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repository/repository.dart';

class ProfileDetailsTabBody extends StatelessWidget {
  const ProfileDetailsTabBody({
    this.profileTabBloc,
    this.affirmationsBloc,
  }) : super(key: PositiveAffirmationsKeys.profileDetails);

  final ProfileTabBloc? profileTabBloc;
  final AffirmationsBloc? affirmationsBloc;

  Widget _mapBody() {
    return BlocBuilder<ProfileTabBloc, ProfileTab>(
      builder: (context, tab) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (tab) {
              case ProfileTab.affirmations:
                context
                    .read<AffirmationsBloc>()
                    .add(const AffirmationsLoaded(forUser: true));
                return ProfileAffirmationsTab(
                  key: PositiveAffirmationsKeys.profileAffirmationsSubtabBody(
                      state.user.id),
                  user: state.user,
                );
              case ProfileTab.letters:
                return ProfileLettersTab(
                  key: PositiveAffirmationsKeys.profileLettersSubtabBody(
                      state.user.id),
                );
              default:
                return ProfileAffirmationsTab(
                  key: PositiveAffirmationsKeys.profileAffirmationsSubtabBody(
                      state.user.id),
                  user: state.user,
                );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _DetailsContent(),
        const ProfileNavigator(),
        Expanded(child: _mapBody()),
      ],
    );

    return MultiBlocProvider(
      providers: [
        if (profileTabBloc != null)
          BlocProvider<ProfileTabBloc>.value(
            value: profileTabBloc!,
            child: content,
          )
        else
          BlocProvider<ProfileTabBloc>(
            create: (_) => ProfileTabBloc(),
            child: content,
          ),
        if (affirmationsBloc != null)
          BlocProvider<AffirmationsBloc>.value(value: affirmationsBloc!),
      ],
      child: content,
    );
  }
}

class _DetailsContent extends StatelessWidget {
  static const Padding _contentPadding =
      Padding(padding: EdgeInsets.only(top: 10));

  Widget _buildCountsRow(BuildContext context, AppUser user) {
    final affirmationsCount = BlocBuilder<AffirmationsBloc, AffirmationsState>(
        builder: (context, state) {
      return _CountDisplay(
        label: 'Affirmations',
        value: state.affirmations
            .where((element) => element.createdById == user.id)
            .length,
        key: PositiveAffirmationsKeys.profileAffirmationsCount(user.id),
      );
    });
    final lettersCount = BlocBuilder<AffirmationsBloc, AffirmationsState>(
        builder: (context, state) {
      return _CountDisplay(
        label: 'Letters',
        value: state.affirmations
            .where((element) => element.createdById == user.id)
            .length,
        key: PositiveAffirmationsKeys.profileLettersCount(user.id),
      );
    });
    final reaffirmationsCount =
        BlocBuilder<AffirmationsBloc, AffirmationsState>(
            builder: (context, state) {
      return _CountDisplay(
        label: 'Reaffirmations',
        value: state.affirmations
            .where((element) => element.createdById == user.id)
            .length,
        key: PositiveAffirmationsKeys.profileReaffirmationsCount(user.id),
      );
    });

    return Wrap(
      spacing: 30,
      children: [
        affirmationsCount,
        lettersCount,
        reaffirmationsCount,
      ],
    );
  }

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
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            _contentPadding,
            Text(
              state.user.nickName,
              key: PositiveAffirmationsKeys.profileNickName(state.user.id),
            ),
            _contentPadding,
            _buildCountsRow(context, state.user),
            _contentPadding,
          ],
        );
      },
    );
  }
}

class _CountDisplay extends StatelessWidget {
  const _CountDisplay({
    required this.label,
    required this.value,
    required Key key,
  }) : super(key: key);

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$value'),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(this.user);

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker _picker = ImagePicker();
        final XFile? file = await _picker.pickImage(source: ImageSource.camera);
        if (file != null) {
          Uint8List imageBytes = await file.readAsBytes();
          String imageBase64 = base64Encode(imageBytes);
          BlocProvider.of<ProfileBloc>(context)
              .add(PictureUpdated(pictureB64Enc: imageBase64));
        }
      },
      child: Stack(
        children: [
          if (user.pictureUrl.isEmpty ||
              user.pictureUrl == AppUser.empty.pictureUrl)
            CircleAvatar(
              key: PositiveAffirmationsKeys.profilePicture(user.id),
              child: Text(
                user.nameInitials().toUpperCase(),
                key: PositiveAffirmationsKeys.profilePictureEmptyLabel(user.id),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              radius: 36,
            )
          else
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return CircleAvatar(
                  key: PositiveAffirmationsKeys.profilePictureImage(user.id),
                  backgroundImage: NetworkImage(user.pictureUrl),
                  child: state.pictureUpdateStatus ==
                          FormzStatus.submissionInProgress
                      ? const CircularProgressIndicator()
                      : null,
                  radius: 36,
                );
              },
            ),
          const Positioned(
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
