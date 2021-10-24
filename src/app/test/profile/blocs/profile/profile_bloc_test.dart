import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/repository.dart';

import '../../../mocks/user_repository_mock.dart';

void main() {
  const validName = 'mockName';
  // const invalidName = 'mock-name.invalid';
  const validNickName = 'mockNickName';
  // const invalidNickName = 'mock-invalid.nickname';

  late ProfileBloc profileBloc;
  late UserRepository userRepository;

  const mockUser = PositiveAffirmationsRepositoryConsts.seedUser;
  const mockUserWithPicture =
      PositiveAffirmationsRepositoryConsts.seedUserWithPicture;

  group('[ProfileBloc]', () {
    setUp(() {
      userRepository = MockUserRepository();
      profileBloc = ProfileBloc(userRepository: userRepository);
    });

    group('[UserCreated]', () {
      blocTest<ProfileBloc, ProfileState>(
        'supplying user emits updated state',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(const UserCreated(user: mockUser));
        },
        expect: () => <ProfileState>[
          const ProfileState(user: mockUser),
        ],
      );
      blocTest<ProfileBloc, ProfileState>(
        'whitespaces are sanitized for name and nickname',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(UserCreated(
            user: mockUser.copyWith(
              name: '  ${mockUser.name}  ',
              nickName: '  ${mockUser.nickName}  ',
            ),
          ));
        },
        expect: () => <ProfileState>[
          const ProfileState(user: mockUser),
        ],
      );
    });

    group('[ProfileEdited]', () {
      blocTest<ProfileBloc, ProfileState>(
        'event updates user in state',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(
              ProfileEdited(name: mockUser.name, nickName: mockUser.nickName));
        },
        expect: () => <ProfileState>[
          ProfileState(
            user: AppUser.empty.copyWith(
              name: mockUser.name,
              nickName: mockUser.nickName,
            ),
          ),
        ],
      );
      blocTest<ProfileBloc, ProfileState>(
        'whitespaces are sanitized',
        build: () => profileBloc,
        seed: () => const ProfileState(user: mockUser),
        act: (bloc) {
          bloc.add(const ProfileEdited(
            name: '  $validName  ',
            nickName: '  $validNickName  ',
          ));
        },
        expect: () => <ProfileState>[
          ProfileState(
            user: mockUser.copyWith(
              name: validName,
              nickName: validNickName,
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
          bloc.add(PictureUpdated(
            pictureB64Enc: mockUserWithPicture.pictureB64Enc,
          ));
        },
        expect: () => <ProfileState>[
          ProfileState(
            user: AppUser.empty.copyWith(
              pictureB64Enc: mockUserWithPicture.pictureB64Enc,
            ),
          ),
        ],
      );
    });
  });
}
