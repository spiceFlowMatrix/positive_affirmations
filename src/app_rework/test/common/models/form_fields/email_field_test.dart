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
      test('error is `empty` given value is an empty string', () {
        expect(
          const EmailField.dirty('').error,
          EmailFieldValidationError.empty,
        );
      });

      test('error is `invalid` given the value is not an email', () {
        expect(
          const EmailField.dirty(invalidEmailString).error,
          EmailFieldValidationError.invalid,
        );
      });

      test('error is null given value is a valid email', () {
        expect(
          const EmailField.dirty(validEmailString).error,
          isNull,
        );
      });
    });
  });
}
