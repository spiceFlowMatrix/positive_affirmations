import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  group('[AffirmationsEvent]', () {
    group('[AffirmationCreated]', () {
      test('supports value comparisons', () {
        expect(AffirmationCreated('-', '-'), AffirmationCreated('-', '-'));
      });
    });
    group('[AffirmationUpdated]', () {
      test('supports value comparisons', () {
        expect(
            AffirmationUpdated(1, '-', '-'), AffirmationUpdated(1, '-', '-'));
      });
    });
    group('[AffirmationActivationToggled]', () {
      test('supports value comparisons', () {
        expect(
            AffirmationActivationToggled(1), AffirmationActivationToggled(1));
      });
    });
    group('[AffirmationLiked]', () {
      test('supports value comparisons', () {
        expect(AffirmationLiked(1), AffirmationLiked(1));
      });
    });
    group('[ReaffirmationCreated]', () {
      test('supports value comparisons', () {
        expect(
          ReaffirmationCreated(
            affirmationId: 1,
            value: ReaffirmationValue.goodWork,
            font: ReaffirmationFont.montserrat,
            stamp: ReaffirmationStamp.medal,
          ),
          ReaffirmationCreated(
            affirmationId: 1,
            value: ReaffirmationValue.goodWork,
            font: ReaffirmationFont.montserrat,
            stamp: ReaffirmationStamp.medal,
          ),
        );
      });
    });
  });
}
