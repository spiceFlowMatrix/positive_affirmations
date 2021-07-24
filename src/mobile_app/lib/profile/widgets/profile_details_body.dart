import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';
import 'package:mobile_app/profile/widgets/profile_navigator.dart';
import 'package:repository/repository.dart';

class ProfileDetailsTabBody extends StatelessWidget {
  const ProfileDetailsTabBody({
    this.profileTabBloc,
    this.affirmationsBloc,
  }) : super(key: PositiveAffirmationsKeys.profileDetails);

  final ProfileTabBloc? profileTabBloc;
  final AffirmationsBloc? affirmationsBloc;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _DetailsContent(),
        Expanded(child: _TabsContainer()),
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
      const Padding(padding: EdgeInsets.only(top: 10));

  Widget _buildCountsRow(BuildContext context, User user) {
    final affirmationsCount = BlocBuilder<AffirmationsBloc, AffirmationsState>(
        builder: (context, state) {
      return _CountDisplay(
        label: 'Affirmations',
        value: state.affirmations
            .where((element) => element.createdById == user.id)
            .length,
        key: PositiveAffirmationsKeys.profileAffirmationsCount('${user.id}'),
      );
    });
    final lettersCount = BlocBuilder<AffirmationsBloc, AffirmationsState>(
        builder: (context, state) {
      return _CountDisplay(
        label: 'Letters',
        value: state.affirmations
            .where((element) => element.createdById == user.id)
            .length,
        key: PositiveAffirmationsKeys.profileLettersCount('${user.id}'),
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
        key: PositiveAffirmationsKeys.profileReaffirmationsCount('${user.id}'),
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
              style: TextStyle(
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
    required this.key,
  }) : super(key: key);

  final String label;
  final int value;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$value'),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
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
        if (file != null) {
          Uint8List imageBytes = await file.readAsBytes();
          String imageBase64 = base64Encode(imageBytes);
          BlocProvider.of<ProfileBloc>(context)
              .add(PictureUpdated(pictureB64Enc: imageBase64));
        }
      },
      child: Stack(
        children: [
          if (user.pictureB64Enc.isEmpty ||
              user.pictureB64Enc == User.empty.pictureB64Enc)
            CircleAvatar(
              key: PositiveAffirmationsKeys.profilePicture(user.id),
              child: Text(
                user.nameInitials().toUpperCase(),
                key: PositiveAffirmationsKeys.profilePictureEmptyLabel(user.id),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              radius: 36,
            )
          else
            CircleAvatar(
              key: PositiveAffirmationsKeys.profilePictureImage(user.id),
              backgroundImage: MemoryImage(
                Base64Decoder().convert(user.pictureB64Enc),
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

class _TabsContainer extends StatelessWidget {
  Widget _mapBody(ProfileTab tab) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (tab) {
          case ProfileTab.affirmations:
            return _AffirmationsTabBody(
              key: PositiveAffirmationsKeys.profileAffirmationsSubtabBody(
                  state.user.id),
              user: state.user,
            );
          case ProfileTab.letters:
            return Center(
              key: PositiveAffirmationsKeys.profileLettersSubtabBody(
                  state.user.id),
              child: Text('Letters'),
            );
          default:
            return _AffirmationsTabBody(
              key: PositiveAffirmationsKeys.profileAffirmationsSubtabBody(
                  state.user.id),
              user: state.user,
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileTabBloc, ProfileTab>(
      builder: (context, tab) {
        return Container(
          height: 500,
          child: Column(
            children: [
              ProfileNavigator(
                activeTab: tab,
                onTabSelected: (tab) {
                  BlocProvider.of<ProfileTabBloc>(context).add(TabUpdated(tab));
                },
              ),
              _mapBody(tab),
            ],
          ),
        );
      },
    );
  }
}

class _AffirmationsTabBody extends StatelessWidget {
  _AffirmationsTabBody({
    required this.key,
    required this.user,
  }) : super(key: key);

  final Key key;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffirmationsBloc, AffirmationsState>(
      builder: (context, state) {
        final toRenderAffirmations = state.affirmations
            .where((element) => element.createdById == user.id)
            .toList();
        return ListView.builder(
          itemCount: toRenderAffirmations.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  key: PositiveAffirmationsKeys.profileAffirmationItem(
                      '${toRenderAffirmations[index].id}'),
                  title: Text(
                    toRenderAffirmations[index].title,
                    key: PositiveAffirmationsKeys.profileAffirmationItemTitle(
                        '${toRenderAffirmations[index].id}'),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    final bloc = BlocProvider.of<AffirmationsBloc>(context);
                    Navigator.of(context).pushNamed(
                      AffirmationFormScreen.routeName,
                      arguments: AffirmationFormScreenArguments(
                        affirmationsBloc: bloc,
                        toUpdateAffirmation: toRenderAffirmations[index],
                      ),
                    );
                  },
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    key:
                        PositiveAffirmationsKeys.profileAffirmationItemTrailing(
                            '${toRenderAffirmations[index].id}'),
                    size: 15,
                    color: Colors.black,
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1.5,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
