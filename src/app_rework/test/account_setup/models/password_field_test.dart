import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';

void main() {
  const validPasswordString = 'testValidPassword123@';
  group('[PasswordField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        const password = PasswordField.pure();
        expect(password.value, '');
        expect(password.pure, true);
      });
      test('dirty creates correct instance', () {
        const password = PasswordField.dirty(validPasswordString);
        expect(password.value, validPasswordString);
        expect(password.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns valid when valid value is supplied', () {
        expect(
          const PasswordField.dirty(validPasswordString).error,
          isNull,
        );
      });
      test('returns invalid when invalid value is supplied', () {
        expect(
          const PasswordField.dirty('').error,
          PasswordFieldValidationError.empty,
        );
      });
    });
  });
}
