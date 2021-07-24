import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../../mocks/user_repository_mock.dart';

void main() {
  late UserRepository userRepository;
  late SignUpBloc signUpBloc;

  const validName = 'mockName';
  const invalidName = 'mock-name.invalid';
  const validNickName = 'mockNickName';
  const invalidNickName = 'mock-invalid.nickname';

  const SignUpState mockCreatableState = SignUpState(
    name: NameField.dirty(validName),
    nameStatus: FormzStatus.submissionSuccess,
    nickName: NickNameField.dirty(validNickName),
    nickNameStatus: FormzStatus.submissionSuccess,
  );

  final User mockCreatedUser = User(
    id: '23fe3r',
    name: mockCreatableState.name.value,
    nickName: mockCreatableState.nickName.value,
  );

  setUp(() {
    userRepository = MockUserRepository();
    signUpBloc = SignUpBloc(userRepository: userRepository);
  });

  group('[SignUpBloc]', () {
    test(('initial state is SignUpState'), () {
      expect(signUpBloc.state, const SignUpState());
    });

    group('[NameUpdated]', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [valid] when valid name is updated',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NameUpdated(validName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when invalid name is updated',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NameUpdated(invalidName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(invalidName),
            nameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[NameSubmitted]', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [submissionSuccess] when valid name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NameUpdated(validName))..add(NameSubmitted());
        },
        expect: () => const <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits same state when invalid name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NameUpdated(invalidName))..add(NameSubmitted());
        },
        expect: () => const <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(invalidName),
            nameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[NickNameUpdated]', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits same state when nickName is updated before name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NickNameUpdated(validNickName));
        },
        expect: () => const <SignUpState>[
          const SignUpState(),
        ],
      );
      blocTest<SignUpBloc, SignUpState>(
        'emits [valid] when valid nickName is updated',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(validName))
            ..add(const NameSubmitted())
            ..add(const NickNameUpdated(validNickName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: const NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when invalid nickName is updated',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(validName))
            ..add(const NameSubmitted())
            ..add(const NickNameUpdated(invalidNickName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: const NickNameField.dirty(invalidNickName),
            nickNameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[NickNameSubmitted]', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits same state when nickName is submitted before name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          const SignUpState(),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits [submissionSuccess] when valid nickName is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(validName))
            ..add(NameSubmitted())
            ..add(NickNameUpdated(validNickName))
            ..add(NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: const NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: const NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits same state when invalid nickName is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(validName))
            ..add(NameSubmitted())
            ..add(NickNameUpdated(invalidNickName))
            ..add(NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: const NickNameField.dirty(invalidNickName),
            nickNameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[UserSubmitted]', () {
      blocTest<SignUpBloc, SignUpState>(
        'valid submission workflow takes place upon valid user submission',
        build: () {
          when(() => userRepository.createUser(
                mockCreatableState.name.value,
                mockCreatableState.nickName.value,
              )).thenAnswer((_) => Future.value(mockCreatedUser));

          return signUpBloc;
        },
        seed: () => mockCreatableState,
        act: (bloc) {
          bloc..add(UserSubmitted());
        },
        verify: (_) {
          verify(() => userRepository.createUser(
                mockCreatableState.name.value,
                mockCreatableState.nickName.value,
              )).called(1);
        },
        expect: () => <SignUpState>[
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionInProgress,
          ),
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionSuccess,
            createdUser: mockCreatedUser,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'valid submission workflow takes place upon repository exception',
        build: () {
          when(() => userRepository.createUser(
                mockCreatableState.name.value,
                mockCreatableState.nickName.value,
              )).thenThrow(Exception('oops!'));

          return signUpBloc;
        },
        seed: () => mockCreatableState,
        act: (bloc) {
          bloc..add(UserSubmitted());
        },
        verify: (_) {
          verify(() => userRepository.createUser(
                mockCreatableState.name.value,
                mockCreatableState.nickName.value,
              )).called(1);
        },
        expect: () => <SignUpState>[
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionInProgress,
          ),
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionFailure,
          ),
        ],
      );
    });
  });
}
