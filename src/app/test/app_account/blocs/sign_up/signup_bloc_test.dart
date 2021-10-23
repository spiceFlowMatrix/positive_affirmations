import 'package:app/app_account/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
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

  final AppUser mockCreatedUser = AppUser(
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
          bloc.add(const NameUpdated(validName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when invalid name is updated',
        build: () => signUpBloc,
        act: (bloc) {
          bloc.add(const NameUpdated(invalidName));
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: NameField.dirty(invalidName),
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
          bloc
            ..add(const NameUpdated(validName))
            ..add(const NameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'sanitizes spaces',
        build: () => signUpBloc,
        seed: () => const SignUpState(
          name: NameField.dirty('  $validName  '),
          nameStatus: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc.add(const NameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits same state when invalid name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(invalidName))
            ..add(const NameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(invalidName),
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
          bloc.add(const NickNameUpdated(validNickName));
        },
        expect: () => const <SignUpState>[
          SignUpState(),
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
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
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
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(invalidNickName),
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
          bloc.add(const NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'sanitizes spaces',
        build: () => signUpBloc,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
          nickName: NickNameField.dirty('  $validNickName  '),
          nickNameStatus: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc.add(const NickNameSubmitted());
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits [submissionSuccess] when valid nickName is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc
            ..add(const NameUpdated(validName))
            ..add(const NameSubmitted())
            ..add(const NickNameUpdated(validNickName))
            ..add(const NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.valid,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
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
            ..add(const NameSubmitted())
            ..add(const NickNameUpdated(invalidNickName))
            ..add(const NickNameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(invalidNickName),
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
                name: mockCreatableState.name.value,
                email: mockCreatableState.email.value,
                password: mockCreatableState.password.value,
                nickName: mockCreatableState.nickName.value,
              )).thenAnswer((_) => Future.value(mockCreatedUser));

          return signUpBloc;
        },
        seed: () => mockCreatableState,
        act: (bloc) {
          bloc.add(AccountDetailsSubmitted());
        },
        verify: (_) {
          verify(() => userRepository.createUser(
                name: mockCreatableState.name.value,
                email: mockCreatableState.email.value,
                password: mockCreatableState.password.value,
                nickName: mockCreatableState.nickName.value,
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
                name: mockCreatableState.name.value,
                email: mockCreatableState.email.value,
                password: mockCreatableState.password.value,
                nickName: mockCreatableState.nickName.value,
              )).thenThrow(Exception('oops!'));

          return signUpBloc;
        },
        seed: () => mockCreatableState,
        act: (bloc) {
          bloc.add(AccountDetailsSubmitted());
        },
        verify: (_) {
          verify(() => userRepository.createUser(
                name: mockCreatableState.name.value,
                email: mockCreatableState.email.value,
                password: mockCreatableState.password.value,
                nickName: mockCreatableState.nickName.value,
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
