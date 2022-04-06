import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/email_field.dart';

void main() {
  const invalidEmailString = 'test.com';
  const validEmailString = 'test@email.com';

  group('[EmailField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        const email = EmailField.pure();
        expect(email.value, '');
        expect(email.pure, isTrue);
      });
      test('dirty creates correct instance', () {
        const email = EmailField.dirty(invalidEmailString);
        expect(email.value, invalidEmailString);
        expect(email.pure, isFalse);
      });
    });

    group('[Validators]', () {
      test('returns empty when email is empty', () {
        expect(
          const EmailField.dirty('').error,
          EmailFieldValidationError.empty,
        );
      });

      test('is valid when valid email is provided', () {
        expect(
          const EmailField.dirty(validEmailString).error,
          isNull,
        );
      });

      test('returns invalid when supplied string does not match an email', () {
        expect(
          const EmailField.dirty(invalidEmailString).error,
          EmailFieldValidationError.invalid,
        );
      });
    });
  });
}
