import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';

void main() {
  group('[ApptabEvent]', () {
    group('[TabUpdated]', () {
      test('supports value comparisons', () {
        expect(
            TabUpdated(AppTab.affirmations), TabUpdated(AppTab.affirmations));
      });
    });
  });
}
