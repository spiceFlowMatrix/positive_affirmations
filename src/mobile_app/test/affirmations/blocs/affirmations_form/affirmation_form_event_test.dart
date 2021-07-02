import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';

void main() {
  group('[AffirmationFormEvent]', () {
    group('[TitleUpdated]', () {
      test('supports value comparisons', () {
        expect(TitleUpdated('-'), TitleUpdated('-'));
      });
    });
    group('[SubtitleUpdated]', () {
      test('supports value comparisons', () {
        expect(SubtitleUpdated('-'), SubtitleUpdated('-'));
      });
    });
    group('[AffirmationSubmitted]', () {
      test('supports value comparisons', () {
        expect(AffirmationSubmitted(), AffirmationSubmitted());
      });
    });
  });
}
