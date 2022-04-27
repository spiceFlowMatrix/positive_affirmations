import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:chopper/chopper.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:repository/repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockApiUserResponse extends Mock implements Response<UserDto> {}

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  const validNameString = 'Valid Name';
  const invalidNumericNameString = 'Valid1 Name2';
  const validEmailString = 'test@email.com';
  const invalidEmailString = 'test.com';
  const validPasswordString = '1234567As';
  const invalidShortPasswordString = '1234As';

  final mockValidSignUpCommand = SignUpCommandDto(
    displayName: validNameString,
    nickName: validNameString,
    email: validEmailString,
    password: validPasswordString,
  );

  late ApiClient apiClient;
  late AuthenticationRepository authRepo;
  late SignUpFormCubit cubit;

  setUp(() {
    authRepo = MockAuthRepo();
    apiClient = MockApiClient();
    cubit = SignUpFormCubit(
      apiClient: apiClient,
      authRepo: authRepo,
    );
  });

  group('[SignUpFormCubit]', () {
    test('initial state is `SignUpFormState()`', () {
      expect(cubit.state, equals(const SignUpFormState()));
    });

    group('[UpdateName]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'emits updated name',
        build: () => cubit,
        act: (cubit) {
          cubit.updateName(validNameString);
        },
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            status: FormzStatus.invalid,
          )
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid and valid value is supplied, emits [valid] state',
        seed: () => const SignUpFormState(
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        build: () => cubit,
        act: (cubit) => cubit.updateName(validNameString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid and invalid value is supplied, emits [invalid] state',
        seed: () => const SignUpFormState(
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        build: () => cubit,
        act: (cubit) => cubit.updateName(invalidNumericNameString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(invalidNumericNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[UpdateNickName]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'emits state with updated nickname',
        build: () => cubit,
        act: (cubit) => cubit.updateNickname(validNameString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            nickName: NullablePersonNameField.dirty(validNameString),
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid and valid value is supplied, emits [valid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.updateNickname(validNameString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.valid,
          )
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid and invalid value is supplied, emits [invalid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.updateNickname(invalidNumericNameString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(invalidNumericNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          )
        ],
      );
    });

    group('[UpdateEmail]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'emits state with updated email',
        build: () => cubit,
        act: (cubit) => cubit.updateEmail(validEmailString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            email: EmailField.dirty(validEmailString),
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & valid value is supplied, emits [valid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updateEmail(validEmailString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & invalid value is supplied, emits [invalid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updateEmail(invalidEmailString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(invalidEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[UpdatePassword]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'emits state with updated password',
        build: () => cubit,
        act: (cubit) => cubit.updatePassword(validPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            password: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & valid value is supplied, emits [valid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updatePassword(validPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & invalid value is supplied, emits [invalid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updatePassword(invalidShortPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(invalidShortPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[UpdateConfirmPassword]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'emits state with updated password',
        build: () => cubit,
        act: (cubit) => cubit.updateConfirmPassword(validPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & valid value is supplied, emits [valid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updateConfirmPassword(validPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given all other fields are valid & invalid value is supplied, emits [invalid] state',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.updateConfirmPassword(invalidShortPasswordString),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(invalidShortPasswordString),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[Submit]', () {
      blocTest<SignUpFormCubit, SignUpFormState>(
        'doesn\'t do anything if form is pure',
        build: () => cubit,
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'does not do anything if form is invalid',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(invalidNumericNameString),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'does not do anything if submission is in progress',
        build: () => cubit,
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          nickName: NullablePersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.submissionInProgress,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'does not do anything if passwords do not match',
        build: () => cubit,
        seed: () => SignUpFormState(
          name: const PersonNameField.dirty(validNameString),
          nickName: const NullablePersonNameField.dirty(validNameString),
          email: const EmailField.dirty(validEmailString),
          password: const PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(
            validPasswordString + Faker().lorem.word(),
          ),
          status: FormzStatus.invalid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[],
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given valid inputs, makes appropriate service calls and state updates',
        build: () {
          final mockResponse = MockApiUserResponse();
          final mockDto = UserDto(
            displayName: validNameString,
            nickName: validNameString,
            email: validEmailString,
          );
          when(() => mockResponse.body).thenReturn(mockDto);
          when(() => mockResponse.isSuccessful).thenReturn(true);
          when(
            () => apiClient.UsersApiController_signUpUser(
                body: mockValidSignUpCommand),
          ).thenAnswer(
            (_) => Future.value(mockResponse),
          );
          when(
            () => authRepo.logInWithEmailAndPassword(
                email: validEmailString, password: validPasswordString),
          ).thenAnswer((invocation) => Future.value());
          return cubit;
        },
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          nickName: NullablePersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionInProgress,
          ),
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionSuccess,
            error: '',
          ),
        ],
        verify: (_) {
          verify(() => apiClient.UsersApiController_signUpUser(
              body: mockValidSignUpCommand)).called(1);
          verify(
            () => authRepo.logInWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'given signUp command is not successful, updates state with error',
        build: () {
          final mockResponse = MockApiUserResponse();
          when(() => mockResponse.isSuccessful).thenReturn(false);
          when(() => mockResponse.error).thenReturn('api error response message');
          when(
                () => apiClient.UsersApiController_signUpUser(
                body: mockValidSignUpCommand),
          ).thenAnswer(
                (_) => Future.value(mockResponse),
          );
          return cubit;
        },
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          nickName: NullablePersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionInProgress,
          ),
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionFailure,
            error: 'api error response message',
          ),
        ],
        verify: (_) {
          verify(() => apiClient.UsersApiController_signUpUser(
              body: mockValidSignUpCommand)).called(1);
        },
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'catches exception thrown for login in API',
        build: () {
          when(
                () => apiClient.UsersApiController_signUpUser(
                body: mockValidSignUpCommand),
          ).thenAnswer(
                (_) => Future.error('exception thrown'),
          );
          return cubit;
        },
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          nickName: NullablePersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionInProgress,
          ),
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionFailure,
            error: 'exception thrown',
          ),
        ],
        verify: (_) {
          verify(() => apiClient.UsersApiController_signUpUser(
              body: mockValidSignUpCommand)).called(1);
        },
      );

      blocTest<SignUpFormCubit, SignUpFormState>(
        'catches exception thrown for login in authRepo',
        build: () {
          final mockResponse = MockApiUserResponse();
          final mockDto = UserDto(
            displayName: validNameString,
            nickName: validNameString,
            email: validEmailString,
          );
          when(() => mockResponse.body).thenReturn(mockDto);
          when(() => mockResponse.isSuccessful).thenReturn(true);
          when(
                () => apiClient.UsersApiController_signUpUser(
                body: mockValidSignUpCommand),
          ).thenAnswer(
                (_) => Future.value(mockResponse),
          );
          when(
                () => authRepo.logInWithEmailAndPassword(
                email: validEmailString, password: validPasswordString),
          ).thenAnswer((invocation) => Future.error('exception thrown'));
          return cubit;
        },
        seed: () => const SignUpFormState(
          name: PersonNameField.dirty(validNameString),
          nickName: NullablePersonNameField.dirty(validNameString),
          email: EmailField.dirty(validEmailString),
          password: PasswordField.dirty(validPasswordString),
          confirmPassword: PasswordField.dirty(validPasswordString),
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => <SignUpFormState>[
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionInProgress,
          ),
          const SignUpFormState(
            name: PersonNameField.dirty(validNameString),
            nickName: NullablePersonNameField.dirty(validNameString),
            email: EmailField.dirty(validEmailString),
            password: PasswordField.dirty(validPasswordString),
            confirmPassword: PasswordField.dirty(validPasswordString),
            status: FormzStatus.submissionFailure,
            error: 'exception thrown',
          ),
        ],
        verify: (_) {
          verify(() => apiClient.UsersApiController_signUpUser(
              body: mockValidSignUpCommand)).called(1);
          verify(
                () => authRepo.logInWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );
    });
  });
}
