import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  group('[AffirmationsState]', () {
    test('supports value comparisons', () {
      expect(AffirmationsState(), AffirmationsState());
    });

    group('[CopyWith]', () {
      test('returns same object when no values passed', () {
        expect(AffirmationsState().copyWith(), AffirmationsState());
      });

      test(
          'returns state with updated affirmations when `affirmations` is passed',
          () {
        expect(
          AffirmationsState().copyWith(
              affirmations:
                  PositiveAffirmationsRepositoryConsts.seedAffirmations),
          AffirmationsState(
              affirmations:
                  PositiveAffirmationsRepositoryConsts.seedAffirmations),
        );
      });
    });
  });
}
