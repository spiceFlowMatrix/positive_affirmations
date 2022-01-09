import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/account_setup/models/email_field.dart';

void main() {
  const validEmailString = 'test@email.com';
  const invalidEmailString = 'testtest@';
  group('[EmailField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        const email = EmailField.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });
      test('dirty creates correct instance', () {
        const email = EmailField.dirty(validEmailString);
        expect(email.value, validEmailString);
        expect(email.pure, false);
      });
    });

    group('[Validators]', () {
      test('returns empty error if value is empty', () {
        expect(
          const EmailField.dirty('').error,
          EmailFieldValidationError.empty,
        );
      });

      test('returns "invalid_email" error if value is invalid', () {
        expect(
          const EmailField.dirty(invalidEmailString).error,
          EmailFieldValidationError.invalid_email,
        );
      });

      test('recognizes valid email', () {
        expect(
          const EmailField.dirty(validEmailString).error,
          isNull,
        );
      });
    });
  });
}
