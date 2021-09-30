import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_font_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_graphic_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_value_field.dart';
import 'package:repository/repository.dart';

void main() {
  group('[ReaffirmationState]', () {
    test('supports value comparisons', () {
      expect(ReaffirmationState(), equals(ReaffirmationState()));
    });

    group('[CopyWith]', () {
      test('returns same object when no params passed', () {
        expect(ReaffirmationState().copyWith(), equals(ReaffirmationState()));
      });

      test('returns object with updated tab when [tab] is passed', () {
        expect(
          ReaffirmationState().copyWith(tab: ReaffirmationFormTab.stamp),
          equals(ReaffirmationState(tab: ReaffirmationFormTab.stamp)),
        );
      });

      test('returns object with updated value when [value] is passed', () {
        expect(
          ReaffirmationState().copyWith(
              value:
                  ReaffirmationValueField.dirty(ReaffirmationValue.goodWork)),
          equals(ReaffirmationState(
              value:
                  ReaffirmationValueField.dirty(ReaffirmationValue.goodWork))),
        );
      });

      test('returns object with updated font when [font] is passed', () {
        expect(
          ReaffirmationState().copyWith(
              font:
                  ReaffirmationFontField.dirty(ReaffirmationFont.gemunuLibre)),
          equals(ReaffirmationState(
              font:
                  ReaffirmationFontField.dirty(ReaffirmationFont.gemunuLibre))),
        );
      });

      test('returns object with updated graphic when [graphic] is passed', () {
        expect(
          ReaffirmationState().copyWith(
              stamp:
                  ReaffirmationStampField.dirty(ReaffirmationStamp.thumbsUp)),
          equals(ReaffirmationState(
              stamp:
                  ReaffirmationStampField.dirty(ReaffirmationStamp.thumbsUp))),
        );
      });

      test(
          'returns object with updated submissionStatus when [submissionStatus] is passed',
          () {
        expect(
          ReaffirmationState()
              .copyWith(submissionStatus: FormzStatus.submissionFailure),
          equals(ReaffirmationState(
              submissionStatus: FormzStatus.submissionFailure)),
        );
      });
    });
  });
}
