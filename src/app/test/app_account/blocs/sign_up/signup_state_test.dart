import 'package:app/app_account/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

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
          SignUpState(nameStatus: FormzStatus.pure),
        );
      });

      test('returns object with updated name when name is passed', () {
        expect(
          const SignUpState().copyWith(name: name),
          SignUpState(name: name),
        );
      });

      test('returns object with updated nickName when nickName is passed', () {
        expect(
          const SignUpState().copyWith(nickName: nickName),
          SignUpState(nickName: nickName),
        );
      });

      test(
          'returns object with updated nickNameStatus when nickNameStatus is passed',
          () {
        expect(
          const SignUpState()
              .copyWith(nickNameStatus: FormzStatus.submissionInProgress),
          SignUpState(nickNameStatus: FormzStatus.submissionInProgress),
        );
      });

      test('returns object with updated createdUser when createdUser is passed',
          () {
        expect(
          const SignUpState().copyWith(
              createdUser: PositiveAffirmationsRepositoryConsts.seedUser),
          SignUpState(
              createdUser: PositiveAffirmationsRepositoryConsts.seedUser),
        );
      });

      test(
          'returns object with updated submissionStatus when submissionStatus is passed',
          () {
        expect(
          const SignUpState()
              .copyWith(submissionStatus: FormzStatus.submissionInProgress),
          SignUpState(submissionStatus: FormzStatus.submissionInProgress),
        );
      });
    });
  });
}
