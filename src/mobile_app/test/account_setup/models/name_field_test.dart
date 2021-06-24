import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/models/models.dart';

void main() {
  const invalidNameString = 'mock-name';
  const validNameString = 'mockName';

  group('[NameField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        final name = NameField.pure();
        expect(name.value, '');
        expect(name.pure, true);
      });
      test('dirty creates correct instance', () {
        final name = NameField.dirty(invalidNameString);
        expect(name.value, invalidNameString);
        expect(name.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns empty when name is empty', () {
        expect(NameField.dirty('').error, NameFieldValidationError.empty);
      });

      test('is valid when name is not empty', () {
        expect(NameField.dirty(validNameString).error, isNull);
      });

      test('is invalid when name contains symbols', () {
        expect(NameField.dirty(invalidNameString).error,
            NameFieldValidationError.invalid);
      });
    });
  });
}
