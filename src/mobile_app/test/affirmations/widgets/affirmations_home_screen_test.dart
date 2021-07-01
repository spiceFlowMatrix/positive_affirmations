import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/nav_observer.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/apptab_bloc_mock.dart';
import '../../mocks/authentication_bloc_mock.dart';
import '../fixtures/affirmations_home_screen_fixture.dart';

class FakeAffirmationsState extends Fake implements AffirmationsState {}

class FakeAffirmationsEvent extends Fake implements AffirmationsEvent {}

class MockAffirmationsBloc
    extends MockBloc<AffirmationsEvent, AffirmationsState>
    implements AffirmationsBloc {}

void main() {
  late AffirmationsBloc affirmationsBloc;
  late AuthenticationBloc authBloc;
  late ApptabBloc apptabBloc;
  late PositiveAffirmationsNavigatorObserver navigatorObserver;

  setUpAll(() {
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<ApptabEvent>(FakeApptabEvent());
    registerFallbackValue<AppTab>(AppTab.affirmations);
  });

  setUp(() {
    apptabBloc = MockApptabBloc();
    authBloc = MockAuthenticationBloc();
    affirmationsBloc = MockAffirmationsBloc();
    navigatorObserver = PositiveAffirmationsNavigatorObserver();
  });

  group('[AffirmationsHomeScreen]', () {
    group('[AppNavigator]', () {
      testWidgets('navigator tabs exist', (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
        await tester.pumpWidget(AffirmationsHomeScreenFixture(
          apptabBloc: apptabBloc,
          authBloc: authBloc,
        ));

        expect(find.byKey(PositiveAffirmationsKeys.homeTab), findsOneWidget);
        expect(
            find.byKey(PositiveAffirmationsKeys.homeTabIcon), findsOneWidget);
        expect(
            find.byKey(PositiveAffirmationsKeys.homeTabLabel), findsOneWidget);
        expect(find.byKey(PositiveAffirmationsKeys.profileTab), findsOneWidget);
        expect(find.byKey(PositiveAffirmationsKeys.profileTabIcon),
            findsOneWidget);
        expect(find.byKey(PositiveAffirmationsKeys.profileTabLabel),
            findsOneWidget);
      });
    });
  });
}
