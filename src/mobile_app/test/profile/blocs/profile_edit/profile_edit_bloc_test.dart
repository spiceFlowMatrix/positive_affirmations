import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../../mocks/profile_bloc_mock.dart';

void main() {
  const validName = 'mockName';
  const invalidName = 'mock-name.invalid';
  const validNickName = 'mockNickName';
  const invalidNickName = 'mock-invalid.nickname';

  late ProfileBloc profileBloc;
  late ProfileEditBloc profileEditBloc;

  final User mockUser = PositiveAffirmationsConsts.seedUser;

  group('[ProfileEditBloc]', () {
    setUpAll(() {
      registerFallbackValue<ProfileState>(FakeProfileState());
      registerFallbackValue<ProfileEvent>(FakeProfileEvent());
    });
    setUp(() {
      profileBloc = MockProfileBloc();
      when(() => profileBloc.state).thenReturn(ProfileState(user: mockUser));
      profileEditBloc = ProfileEditBloc(profileBloc: profileBloc);
    });

    test('initial state takes name and nickname from profile', () {
      expect(
        profileEditBloc.state,
        ProfileEditState(
          name: NameField.dirty(mockUser.name),
          nickName: NickNameField.dirty(mockUser.nickName),
        ),
      );
    });

    group('[NameUpdated]', () {
      blocTest<ProfileEditBloc, ProfileEditState>(
        'supplying valid name emits valid status',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(mockUser.name),
          nickName: NickNameField.dirty(mockUser.nickName),
          status: FormzStatus.pure,
        ),
        act: (bloc) {
          bloc..add(NameUpdated(validName));
        },
        expect: () => <ProfileEditState>[
          const ProfileEditState().copyWith(
            name: NameField.dirty(validName),
            nickName: NickNameField.dirty(mockUser.nickName),
            status: FormzStatus.valid,
          ),
        ],
      );
      blocTest<ProfileEditBloc, ProfileEditState>(
        'supplying invalid name emits invalid status',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(mockUser.name),
          nickName: NickNameField.dirty(mockUser.nickName),
          status: FormzStatus.pure,
        ),
        act: (bloc) {
          bloc..add(NameUpdated(invalidName));
        },
        expect: () => <ProfileEditState>[
          ProfileEditState(
            name: NameField.dirty(invalidName),
            nickName: NickNameField.dirty(mockUser.nickName),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[NickNameUpdated]', () {
      blocTest<ProfileEditBloc, ProfileEditState>(
        'supplying valid nickname emits valid status',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(mockUser.name),
          nickName: NickNameField.dirty(mockUser.nickName),
          status: FormzStatus.pure,
        ),
        act: (bloc) {
          bloc..add(NickNameUpdated(validNickName));
        },
        expect: () => <ProfileEditState>[
          ProfileEditState(
            name: NameField.dirty(mockUser.name),
            nickName: NickNameField.dirty(validNickName),
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<ProfileEditBloc, ProfileEditState>(
        'supplying invalid nickname emits invalid status',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(mockUser.name),
          nickName: NickNameField.dirty(mockUser.nickName),
          status: FormzStatus.pure,
        ),
        act: (bloc) {
          bloc..add(NickNameUpdated(invalidNickName));
        },
        expect: () => <ProfileEditState>[
          ProfileEditState(
            name: NameField.dirty(mockUser.name),
            nickName: NickNameField.dirty(invalidNickName),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[ProfileEditSubmitted]', () {
      blocTest<ProfileEditBloc, ProfileEditState>(
        'submitting valid form triggers profile updated',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(validName),
          nickName: NickNameField.dirty(validNickName),
          status: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc..add(ProfileEditSubmitted());
        },
        expect: () => <ProfileEditState>[
          ProfileEditState(
            name: NameField.dirty(validName),
            nickName: NickNameField.dirty(validNickName),
            status: FormzStatus.submissionInProgress,
          ),
          ProfileEditState(
            name: NameField.dirty(validName),
            nickName: NickNameField.dirty(validNickName),
            status: FormzStatus.submissionSuccess,
          ),
        ],
        verify: (_) {
          verify(() => profileBloc.add(ProfileEdited(
                name: validName,
                nickName: validNickName,
              )));
        },
      );
      blocTest<ProfileEditBloc, ProfileEditState>(
        'submitting invalid form does not do anything. state remains unchanged',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty(invalidName),
          nickName: NickNameField.dirty(invalidNickName),
          status: FormzStatus.invalid,
        ),
        act: (bloc) {
          bloc..add(ProfileEditSubmitted());
        },
        verify: (_) {
          verifyNever(() => profileBloc.add(ProfileEdited(
                name: invalidName,
                nickName: invalidNickName,
              )));
        },
      );
      blocTest<ProfileEditBloc, ProfileEditState>(
        'whitespaces are sanitized',
        build: () => profileEditBloc,
        seed: () => ProfileEditState(
          name: NameField.dirty('  $validName  '),
          nickName: NickNameField.dirty('  $validNickName  '),
          status: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc..add(ProfileEditSubmitted());
        },
        expect: () => <ProfileEditState>[
          ProfileEditState(
            name: NameField.dirty(validName),
            nickName: NickNameField.dirty(validNickName),
            status: FormzStatus.submissionInProgress,
          ),
          ProfileEditState(
            name: NameField.dirty(validName),
            nickName: NickNameField.dirty(validNickName),
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );
    });
  });
}
