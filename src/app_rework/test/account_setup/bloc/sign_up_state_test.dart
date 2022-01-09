import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account_setup/bloc/sign_up/sign_up_cubit.dart';
import 'package:positive_affirmations/account_setup/models/name_field.dart';
import 'package:positive_affirmations/account_setup/models/nick_name_field.dart';

void main() {
  const name = NameField.dirty('mockName');
  const nickName = NickNameField.dirty('mockNickName');
  group('[SignUpState]', () {
    test('supports value comparisons', () {
      expect(const SignUpState(), const SignUpState());
    });

    group('[CopyWith]', () {
      test('returns the same object when no values are passed', () {
        expect(const SignUpState().copyWith(), const SignUpState());
      });

      test('returns object with updated nameStatus when nameStatus is passed',
          () {
        expect(
          const SignUpState().copyWith(nameStatus: FormzStatus.pure),
          const SignUpState(nameStatus: FormzStatus.pure),
        );
      });

      test('returns object with updated name when name is passed', () {
        expect(
          const SignUpState().copyWith(name: name),
          const SignUpState(name: name),
        );
      });

      test('returns object with updated nickName when nickName is passed', () {
        expect(
          const SignUpState().copyWith(nickName: nickName),
          const SignUpState(nickName: nickName),
        );
      });

      test(
          'returns object with updated nickNameStatus when nickNameStatus is passed',
          () {
        expect(
          const SignUpState()
              .copyWith(nickNameStatus: FormzStatus.submissionInProgress),
          const SignUpState(nickNameStatus: FormzStatus.submissionInProgress),
        );
      });

      test(
          'returns object with updated submissionStatus when submissionStatus is passed',
          () {
        expect(
          const SignUpState()
              .copyWith(submissionStatus: FormzStatus.submissionInProgress),
          const SignUpState(submissionStatus: FormzStatus.submissionInProgress),
        );
      });
    });
  });
}
