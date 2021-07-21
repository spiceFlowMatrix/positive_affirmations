import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';

void main() {
  group('[ProfileTabEvent]', () {
    group('[TabUpdated]', () {
      test('supports value comparisons', () {
        expect(
          TabUpdated(ProfileTab.affirmations),
          TabUpdated(ProfileTab.affirmations),
        );
      });
    });
  });
}
