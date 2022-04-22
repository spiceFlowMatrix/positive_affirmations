import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';

void main() {
  const name = PersonNameField.dirty('test person name');
  const nickName = NullablePersonNameField.dirty('test nick');
  const email = EmailField.dirty('test@email.com');
  const password = PasswordField.dirty('1234567As');

  group('[SignUpFormState]', () {
    test('supports value comparisons', () {
      expect(const SignUpFormState(), const SignUpFormState());
    });

    group('[passwordConfirmed]', () {
      test(
          'returns true if values for `password` and `confirmPassword` fields match exactly',
          () {
        const state = SignUpFormState(
          password: password,
          confirmPassword: password,
        );
        expect(
          state.passwordConfirmed,
          isTrue,
        );
      });
    });

    group('[CopyWith]', () {
      test('returns identical object if no parameters are passed', () {
        expect(const SignUpFormState().copyWith(), const SignUpFormState());
        expect(
          const SignUpFormState(name: name).copyWith(),
          const SignUpFormState(name: name),
        );
      });

      test('returns object with updated name when name is passed', () {
        expect(
          const SignUpFormState().copyWith(name: name),
          const SignUpFormState(name: name),
        );
      });

      test('returns object with updated nickname when nickname is passed', () {
        expect(
          const SignUpFormState().copyWith(nickName: nickName),
          const SignUpFormState(nickName: nickName),
        );
      });

      test('returns object with updated email when email is passed', () {
        expect(
          const SignUpFormState().copyWith(email: email),
          const SignUpFormState(email: email),
        );
      });

      test('returns object with updated password when password is passed', () {
        expect(
          const SignUpFormState().copyWith(password: password),
          const SignUpFormState(password: password),
        );
      });

      test(
          'returns object with updated confirmPassword when confirmPassword is passed',
          () {
        expect(
          const SignUpFormState().copyWith(confirmPassword: password),
          const SignUpFormState(confirmPassword: password),
        );
      });

      test('returns object with updated status when new status is passed', () {
        expect(
          const SignUpFormState()
              .copyWith(status: FormzStatus.submissionSuccess),
          const SignUpFormState(status: FormzStatus.submissionSuccess),
        );
      });

      test('returns object with updated error when error is passed', () {
        expect(
          const SignUpFormState().copyWith(error: 'testError'),
          const SignUpFormState(error: 'testError'),
        );
      });
    });
  });
}
