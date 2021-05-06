import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';

void main() {
  late SignUpBloc signUpBloc;

  const validName = 'mockName';
  const invalidName = 'mock-name.invalid';
  const validNickName = 'mockNickName';
  const invalidNickName = 'mock-invalid.nickname';

  setUp(() {
    signUpBloc = SignUpBloc();
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
            nickName: const NickNameField.dirty(invalidNickName),
            nickNameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
