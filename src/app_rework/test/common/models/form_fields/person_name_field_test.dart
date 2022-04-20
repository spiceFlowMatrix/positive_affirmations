import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/person_name_field.dart';

void main() {
  const validNameString = 'Valid Name';
  const invalidSpecialNameString = '.@#.\$%^&*()\\/';
  const invalidNumericNameString = 'Valid1 Name2';

  group('[PersonNameField]', () {
    group('[Constructors]', () {
      test('pure creates valid instance', () {
        expect(
          const PersonNameField.pure().pure,
          isTrue,
        );
      });
      test('dirty creates valid instance', () {
        expect(
          const PersonNameField.dirty(validNameString).pure,
          isFalse,
        );
      });
    });

    group('[Validators]', () {
      test('error is null given valid value', () {
        expect(
          const PersonNameField.dirty(validNameString).error,
          isNull,
        );
      });
      test('returns `invalid` error given value has special characters', () {
        expect(
          const PersonNameField.dirty(invalidSpecialNameString).error,
          PersonNameFieldValidationError.invalid,
        );
      });
      test('returns `invalid` error given value contains numbers', () {
        expect(
          const PersonNameField.dirty(invalidNumericNameString).error,
          PersonNameFieldValidationError.invalid,
        );
      });
      test('returns `empty` error given value is an empty string', () {
        expect(
          const PersonNameField.dirty('').error,
          PersonNameFieldValidationError.empty,
        );
      });
    });
  });
}
