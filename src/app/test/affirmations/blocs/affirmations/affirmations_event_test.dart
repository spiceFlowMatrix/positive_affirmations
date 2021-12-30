import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/repository.dart';

void main() {
  group('[AffirmationsEvent]', () {
    group('[AffirmationCreated]', () {
      test('supports value comparisons', () {
        expect(const AffirmationCreated('-', '-'),
            const AffirmationCreated('-', '-'));
      });
    });
    group('[AffirmationUpdated]', () {
      test('supports value comparisons', () {
        expect(const AffirmationUpdated('-', '-', '-'),
            const AffirmationUpdated('-', '-', '-'));
      });
    });
    group('[AffirmationActivationToggled]', () {
      test('supports value comparisons', () {
        expect(const AffirmationActivationToggled('-'),
            const AffirmationActivationToggled('-'));
      });
    });
    group('[AffirmationLiked]', () {
      test('supports value comparisons', () {
        expect(const AffirmationLiked('-'), const AffirmationLiked('-'));
      });
    });
    group('[ReaffirmationCreated]', () {
      test('supports value comparisons', () {
        expect(
          const ReaffirmationCreated(
            affirmationId: '-',
            value: ReaffirmationValue.goodWork,
            font: ReaffirmationFont.montserrat,
            stamp: ReaffirmationStamp.medal,
          ),
          const ReaffirmationCreated(
            affirmationId: '-',
            value: ReaffirmationValue.goodWork,
            font: ReaffirmationFont.montserrat,
            stamp: ReaffirmationStamp.medal,
          ),
        );
      });
    });
  });
}
