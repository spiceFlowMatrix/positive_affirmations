import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';

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
  });
}
