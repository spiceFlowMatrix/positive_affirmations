import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/password_field.dart';

void main() {
  const validPasswordString = '1234567As';
  const invalidSpecialPasswordString = '1.2@3#.\$5%6^7&8*9()\\/';
  const invalidNumericPasswordString = '12345678910';
  const invalidAlphabeticPasswordString = 'AbCdEfGhIjKlMn';
  const shortPasswordString = '1234As';

  group('[PasswordField]', () {
    group('[Constructors]', () {
      test('pure creates pure instance', () {
        expect(
          const PasswordField.pure().pure,
          isTrue,
        );
      });
      test('dirty creates unpure instance', () {
        expect(
          const PasswordField.dirty(validPasswordString).pure,
          isFalse,
        );
      });
    });

    group('[Validators]', () {
      test('error is null given valid value', () {
        expect(
          const PasswordField.dirty(validPasswordString).error,
          isNull,
        );
      });
      test('returns `invalid` error given value with special characters', () {
        expect(
          const PasswordField.dirty(invalidSpecialPasswordString).error,
          PasswordFieldValidationError.invalid,
        );
      });
      test('returns `invalid` error given value contains only numbers', () {
        expect(
          const PasswordField.dirty(invalidNumericPasswordString).error,
          PasswordFieldValidationError.invalid,
        );
      });
      test('returns `invalid` error given value contains only letters', () {
        expect(
          const PasswordField.dirty(invalidAlphabeticPasswordString).error,
          PasswordFieldValidationError.invalid,
        );
      });
      test('returns `invalid` error given value is shorter 8 characters', () {
        expect(
          const PasswordField.dirty(shortPasswordString).error,
          PasswordFieldValidationError.invalid,
        );
      });
      test('returns `empty` error given value is an empty string', () {
        expect(
          const PasswordField.dirty('').error,
          PasswordFieldValidationError.empty,
        );
      });
    });
  });
}
