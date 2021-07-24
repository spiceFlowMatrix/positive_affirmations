import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/models.dart';

void main() {
  const validNickName = 'nickName';
  const invalidNickName = 'nick-name';

  group('[NickNameField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        final nickName = NickNameField.pure();
        expect(nickName.value, '');
        expect(nickName.pure, true);
      });
      test('dirty creates correct instance', () {
        final nickName = NickNameField.dirty(validNickName);
        expect(nickName.value, validNickName);
        expect(nickName.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns valid whether value is empty or has valid input', () {
        expect(NickNameField.dirty('').error, isNull);
        expect(NickNameField.dirty(validNickName).error, isNull);
      });

      test('returns invalid when value contains symbols', () {
        expect(NickNameField.dirty(invalidNickName).error,
            NickNameFieldValidationError.invalid);
      });
    });
  });
}
