import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/common/blocs/app/app_bloc.dart';
import 'package:repository/repository.dart';

class MockUser extends Mock implements User {}

void main() {
  group('[AppState]', () {
    group('[Unauthenticated]', () {
      test('supports value comparisons', () {
        expect(
          const AppState.unauthenticated(),
          const AppState.unauthenticated(),
        );
      });
      test('has correct status', () {
        const state = AppState.unauthenticated();
        expect(state.status, AppStatus.unauthenticated);
        expect(state.user, User.empty);
      });
    });

    group('[Authenticated]', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          AppState.authenticated(user),
          AppState.authenticated(user),
        );
      });
      test('has correct status', () {
        final user = MockUser();
        final state = AppState.authenticated(user);
        expect(state.status, AppStatus.authenticated);
        expect(state.user, user);
      });
    });
  });
}
