import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account_setup/bloc/sign_up/sign_up_cubit.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';
import 'package:repository/repository.dart';

import '../../mocks/api_client_mock.dart';
import '../../mocks/auth_repository_mock.dart';

void main() {
  late AuthenticationRepository authRepo;
  late ApiClient apiClient;
  late SignUpCubit signUpCubit;

  const validName = 'mockName';
  const invalidName = 'mock-name.invalid';
  const validNickName = 'mockNickName';
  const invalidNickName = 'mock-invalid.nickname';

  const SignUpState mockCreatableState = SignUpState(
    name: NameField.dirty(validName),
    nameStatus: FormzStatus.submissionSuccess,
    nickName: NickNameField.dirty(validNickName),
    nickNameStatus: FormzStatus.submissionSuccess,
    email: EmailField.dirty('test@email.com'),
    password: PasswordField.dirty('test@passwordA1'),
    confirmPassword: PasswordField.dirty('test@passwordA1'),
    passwordStatus: FormzStatus.valid,
    emailStatus: FormzStatus.valid,
    confirmPasswordStatus: FormzStatus.valid,
  );

  final AppUser mockCreatedUser = AppUser(
    id: '23fe3r',
    name: mockCreatableState.name.value,
    nickName: mockCreatableState.nickName.value,
  );

  setUp(() {
    authRepo = MockAuthRepository();
    apiClient = MockApiClient();
    signUpCubit = SignUpCubit(
      authenticationRepository: authRepo,
      apiClient: apiClient,
    );
  });

  group('[SignUpCubit]', () {
    test(('initial state is SignUpState'), () {
      expect(signUpCubit.state, const SignUpState());
    });

    group('[NameUpdated]', () {
      blocTest<SignUpCubit, SignUpState>(
        'emits [valid] when valid name is updated',
        build: () => signUpCubit,
        act: (bloc) {
          bloc.updateName(validName);
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpCubit, SignUpState>(
        'emits [invalid] when invalid name is updated',
        build: () => signUpCubit,
        act: (bloc) {
          bloc.updateName(invalidName);
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
      blocTest<SignUpCubit, SignUpState>(
        'emits [submissionSuccess] when valid name is submitted',
        build: () => signUpCubit,
        act: (bloc) {
          bloc
            ..updateName(validName)
            ..submitName();
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

      blocTest<SignUpCubit, SignUpState>(
        'sanitizes spaces',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty('  $validName  '),
          nameStatus: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc.submitName();
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits same state when invalid name is submitted',
        build: () => signUpCubit,
        act: (bloc) {
          bloc
            ..updateName(invalidName)
            ..submitName();
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
      blocTest<SignUpCubit, SignUpState>(
        'emits same state when nickName is updated before name is submitted',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
        ),
        act: (bloc) {
          bloc.updateNickName(validNickName);
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpCubit, SignUpState>(
        'emits [valid] when valid nickName is updated',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
        ),
        act: (bloc) {
          bloc.updateNickName(validNickName);
        },
        expect: () => <SignUpState>[
          const SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.valid,
          ),
        ],
      );
      blocTest<SignUpCubit, SignUpState>(
        'emits [invalid] when invalid nickName is updated',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
        ),
        act: (bloc) {
          bloc.updateNickName(invalidNickName);
        },
        expect: () => <SignUpState>[
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
      blocTest<SignUpCubit, SignUpState>(
        'emits same state when nickName is submitted before name is submitted',
        build: () => signUpCubit,
        act: (bloc) {
          bloc.submitNickName();
        },
        expect: () => const <SignUpState>[],
      );

      blocTest<SignUpCubit, SignUpState>(
        'sanitizes spaces',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
          nickName: NickNameField.dirty(' $validNickName '),
          nickNameStatus: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc.submitNickName();
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

      blocTest<SignUpCubit, SignUpState>(
        'emits [submissionSuccess] when valid nickName is submitted',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
          nickName: NickNameField.dirty('  $validNickName  '),
          nickNameStatus: FormzStatus.valid,
        ),
        act: (bloc) {
          bloc.submitNickName();
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: NameField.dirty(validName),
            nameStatus: FormzStatus.submissionSuccess,
            nickName: NickNameField.dirty(validNickName),
            nickNameStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits same state when invalid nickName is submitted',
        build: () => signUpCubit,
        seed: () => const SignUpState(
          name: NameField.dirty(validName),
          nameStatus: FormzStatus.submissionSuccess,
          nickName: NickNameField.dirty('  $invalidNickName  '),
          nickNameStatus: FormzStatus.invalid,
        ),
        act: (bloc) {
          bloc.submitNickName();
        },
        expect: () => const <SignUpState>[],
      );
    });

    group('[UserSubmitted]', () {
      blocTest<SignUpCubit, SignUpState>(
        'valid submission workflow takes place upon valid user submission',
        // build: () => signUpCubit,
        build: () {
          when(() => apiClient.UsersApiController_signUpUser(
                body: SignUpCommandDto(
                  displayName: mockCreatableState.name.value,
                  email: mockCreatableState.email.value,
                  password: mockCreatableState.confirmPassword.value,
                  nickName: mockCreatableState.nickName.value,
                ),
              )).thenAnswer((invocation) => Future.value<Response<UserDto>>());
          return signUpCubit;
        },
        seed: () => mockCreatableState,
        act: (bloc) {
          bloc.submitUser();
        },
        verify: (_) {
          verify(() => apiClient.UsersApiController_signUpUser(
                body: SignUpCommandDto(
                  displayName: mockCreatableState.name.value,
                  email: mockCreatableState.email.value,
                  password: mockCreatableState.confirmPassword.value,
                  nickName: mockCreatableState.nickName.value,
                ),
              )).called(1);
        },
        expect: () => <SignUpState>[
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionInProgress,
          ),
          mockCreatableState.copyWith(
            submissionStatus: FormzStatus.submissionSuccess,
          ),
        ],
      );
    });
  });
}
