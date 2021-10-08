import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:app/affirmations/models/subtitle_field.dart';
import 'package:app/affirmations/models/title_field.dart';

void main() {
  const TitleField mockTitle = TitleField.dirty('titleString');
  const SubtitleField mockSubtitle = SubtitleField.dirty('subtitleString');

  group('[AffirmationFormState]', () {
    test('supports value comparisons', () {
      expect(AffirmationFormState(), AffirmationFormState());
    });

    group('[CopyWith]', () {
      test('returns same object when no values are passed', () {
        expect(AffirmationFormState().copyWith(), AffirmationFormState());
      });

      test('returns object with updated title when title is passed', () {
        expect(
          AffirmationFormState().copyWith(title: mockTitle),
          AffirmationFormState(title: mockTitle),
        );
      });

      test('returns object with updated subtitle when subtitle is passed', () {
        expect(
          AffirmationFormState().copyWith(subtitle: mockSubtitle),
          AffirmationFormState(subtitle: mockSubtitle),
        );
      });

      test('returns object with updated status when subtitle is status', () {
        expect(
          AffirmationFormState().copyWith(status: FormzStatus.invalid),
          AffirmationFormState(status: FormzStatus.invalid),
        );
      });
    });
  });
}
