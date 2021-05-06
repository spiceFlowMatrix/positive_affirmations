import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';

void main() {
  late SignUpBloc signUpBloc;

  const validName = 'mockName';
  const invalidName = 'name-invalid.';

  setUp(() {
    signUpBloc = SignUpBloc();
  });

  group('[SignUpBloc]', () {
    test(('initial state is SignUpState'), () {
      expect(signUpBloc.state, const SignUpState());
    });

    group('[NameSubmitted]', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [submissionSuccess] when valid name is submitted',
        build: () => signUpBloc,
        act: (bloc) {
          bloc..add(const NameUpdated(validName))..add(NameSubmitted());
        },
        expect: () => const <SignUpState>[
          SignUpState(
            name: const NameField.dirty(validName),
            nameStatus: FormzStatus.valid,
          ),
          SignUpState(
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
          SignUpState(
            name: const NameField.dirty(invalidName),
            nameStatus: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
