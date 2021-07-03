import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';

void main() {
  const validSubtitle = 'subtitle';
  const invalidSubtitle = 'sub-title';

  group('[SubtitleField]', () {
    group('[Constructors]', () {
      test('pure creates correct instance', () {
        final subtitle = SubtitleField.pure();
        expect(subtitle.value, '');
        expect(subtitle.pure, true);
      });
      test('dirty creates correct instance', () {
        final subtitle = SubtitleField.dirty(validSubtitle);
        expect(subtitle.value, validSubtitle);
        expect(subtitle.pure, false);
      });
    });

    group('[Validator]', () {
      test('returns valid whether value is empty or has valid input', () {
        expect(SubtitleField.dirty('').error, isNull);
        expect(SubtitleField.dirty(validSubtitle).error, isNull);
      });

      test('returns invalid when value contains symbols', () {
        expect(SubtitleField.dirty(invalidSubtitle).error,
            SubtitleFieldValidationError.invalid);
      });
    });
  });
}
