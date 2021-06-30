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
        expect(AffirmationUpdated('-', '-', '-'),
            AffirmationUpdated('-', '-', '-'));
      });
    });
    group('[AffirmationActivationToggled]', () {
      test('supports value comparisons', () {
        expect(AffirmationActivationToggled('-'),
            AffirmationActivationToggled('-'));
      });
    });
    group('[AffirmationLiked]', () {
      test('supports value comparisons', () {
        expect(AffirmationLiked('-'), AffirmationLiked('-'));
      });
    });
  });
}
