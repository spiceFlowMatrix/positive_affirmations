import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  final User mockUser = PositiveAffirmationsConsts.seedUser;

  group('[ProfileEditState]', () {
    test('supports value comparisons', () {
      expect(ProfileEditState(), ProfileEditState());
      expect(
        ProfileEditState(name: NameField.dirty(mockUser.name)),
        ProfileEditState(name: NameField.dirty(mockUser.name)),
      );
      expect(
        ProfileEditState(nickName: NickNameField.dirty(mockUser.nickName)),
        ProfileEditState(nickName: NickNameField.dirty(mockUser.nickName)),
      );
      expect(
        ProfileEditState(status: FormzStatus.valid),
        ProfileEditState(status: FormzStatus.valid),
      );
    });

    group('[copyWith]', () {
      test('returns same object when no params passed', () {
        expect(ProfileEditState().copyWith(), ProfileEditState());
      });

      test('appropriate state is returned given parameters', () {
        expect(
          ProfileEditState().copyWith(name: NameField.dirty(mockUser.name)),
          ProfileEditState(name: NameField.dirty(mockUser.name)),
        );
        expect(
          ProfileEditState()
              .copyWith(nickName: NickNameField.dirty(mockUser.nickName)),
          ProfileEditState(nickName: NickNameField.dirty(mockUser.nickName)),
        );
        expect(
          ProfileEditState().copyWith(status: FormzStatus.valid),
          ProfileEditState(status: FormzStatus.valid),
        );
      });
    });
  });
}
