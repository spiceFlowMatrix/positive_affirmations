import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/nullable_person_name_field.dart';

void main() {
  const validNameString = 'valid person name';
  const invalidNameString = '!nv@l1d.n@mE';

  group('[NullablePersonNameField]', () {
    group('[Constructors]', () {
      test('pure creates valid instance', () {
        const name = NullablePersonNameField.pure();
        expect(name.value, isNull);
        expect(name.pure, isTrue);
      });
      test('dirty creates valid instance', () {
        const name = NullablePersonNameField.dirty(invalidNameString);
        expect(name.value, invalidNameString);
        expect(name.pure, isFalse);
      });
    });

    group('[Validators]', () {
      test('returns `invalid` error given invalid value', () {
        expect(
          const NullablePersonNameField.dirty(invalidNameString).error,
          NullablePersonNameFieldValidationError.invalid,
        );
      });
      test('error is null given valid value', () {
        expect(
          const NullablePersonNameField.dirty(validNameString).error,
          isNull,
        );
      });
      test('error is null given null value', () {
        expect(
          const NullablePersonNameField.dirty(null).error,
          isNull,
        );
      });
      test('error is null given empty value', () {
        expect(
          const NullablePersonNameField.dirty('').error,
          isNull,
        );
      });
    });
  });
}
