import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  late ProfileBloc profileBloc;

  const mockUser = PositiveAffirmationsConsts.seedUser;
  const mockUserWithPicture = PositiveAffirmationsConsts.seedUserWithPicture;

  group('[ProfileBloc]', () {
    setUp(() {
      profileBloc = ProfileBloc();
    });

    group('[UserCreated]', () {
      blocTest<ProfileBloc, ProfileState>(
        'supplying user emits updated state',
        build: () => profileBloc,
        act: (bloc) {
          bloc..add(UserCreated(user: mockUser));
        },
        expect: () => <ProfileState>[
          ProfileState(user: mockUser),
        ],
      );
    });

    group('[ProfileEdited]', () {
      blocTest<ProfileBloc, ProfileState>(
        'event updates user in state',
        build: () => profileBloc,
        act: (bloc) {
          bloc
            ..add(ProfileEdited(
                name: mockUser.name, nickName: mockUser.nickName));
        },
        expect: () => <ProfileState>[
          ProfileState(
            user: User.empty.copyWith(
              name: mockUser.name,
              nickName: mockUser.nickName,
            ),
          ),
        ],
      );
    });

    group('[PictureUpdated]', () {
      blocTest<ProfileBloc, ProfileState>(
        'event updates user picture in state',
        build: () => profileBloc,
        act: (bloc) {
          bloc
            ..add(PictureUpdated(
              pictureB64Enc: mockUserWithPicture.pictureB64Enc,
            ));
        },
        expect: () => <ProfileState>[
          ProfileState(
            user: User.empty.copyWith(
              pictureB64Enc: mockUserWithPicture.pictureB64Enc,
            ),
          ),
        ],
      );
    });
  });
}
