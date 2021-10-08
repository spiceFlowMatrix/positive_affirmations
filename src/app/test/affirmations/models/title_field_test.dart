import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/models/title_field.dart';

void main() {
  const invalidTitleString = 'mock-title';
  const validTitleString = 'mockTitle';

  group('[TitleField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        final title = TitleField.pure();
        expect(title.value, '');
        expect(title.pure, true);
      });
      test('dirty creates correct instance', () {
        final title = TitleField.dirty(invalidTitleString);
        expect(title.value, invalidTitleString);
        expect(title.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns empty when title is empty', () {
        expect(TitleField.dirty('').error, TitleFieldValidationError.empty);
      });

      test('is valid when title is not empty', () {
        expect(TitleField.dirty(validTitleString).error, isNull);
      });

      test('is invalid when title contains symbols', () {
        expect(TitleField.dirty(invalidTitleString).error,
            TitleFieldValidationError.invalid);
      });
    });
  });
}
