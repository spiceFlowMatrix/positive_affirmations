import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/account_setup/models/nick_name_field.dart';

void main() {
  const validNickName = 'nickName';
  const invalidNickName = 'nick-name';

  group('[NickNameField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        const nickName = NickNameField.pure();
        expect(nickName.value, '');
        expect(nickName.pure, true);
      });
      test('dirty creates correct instance', () {
        const nickName = NickNameField.dirty(validNickName);
        expect(nickName.value, validNickName);
        expect(nickName.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns valid whether value is empty or has valid input', () {
        expect(
          const NickNameField.dirty('').error,
          isNull,
        );
        expect(
          const NickNameField.dirty(validNickName).error,
          isNull,
        );
      });

      test('returns invalid when value contains symbols', () {
        expect(
          const NickNameField.dirty(invalidNickName).error,
          NickNameFieldValidationError.invalid,
        );
      });
    });
  });
}
