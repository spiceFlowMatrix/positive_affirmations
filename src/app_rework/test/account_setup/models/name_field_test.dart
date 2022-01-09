import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/account_setup/models/name_field.dart';

void main() {
  const invalidNameString = 'mock-name';
  const validNameString = 'mockName';

  group('[NameField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        const name = NameField.pure();
        expect(name.value, '');
        expect(name.pure, true);
      });
      test('dirty creates correct instance', () {
        const name = NameField.dirty(validNameString);
        expect(name.value, validNameString);
        expect(name.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns empty when name is empty', () {
        expect(
          const NameField.dirty('').error,
          NameFieldValidationError.empty,
        );
      });

      test('is valid when name is not empty', () {
        expect(
          const NameField.dirty(validNameString).error,
          isNull,
        );
      });

      test('is invalid when name contains symbols', () {
        expect(
          const NameField.dirty(invalidNameString).error,
          NameFieldValidationError.invalid,
        );
      });
    });
  });
}
