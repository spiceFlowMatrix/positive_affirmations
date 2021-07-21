import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:repository/src/models/affirmation.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/affirmations_bloc_mock.dart';
import '../../mocks/apptab_bloc_mock.dart';
import '../../mocks/authentication_bloc_mock.dart';
import '../fixtures/affirmations_home_screen_fixture.dart';

void main() {
  late AffirmationsBloc affirmationsBloc;
  late AuthenticationBloc authBloc;
  late ApptabBloc apptabBloc;
  // late PositiveAffirmationsNavigatorObserver navigatorObserver;

  final List<Affirmation> seedAffirmations = <Affirmation>[
    ...PositiveAffirmationsConsts.seedAffirmations,
  ];

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
    // navigatorObserver = PositiveAffirmationsNavigatorObserver();
    when(() => affirmationsBloc.state).thenReturn(AffirmationsState(
      affirmations: seedAffirmations,
    ));
  });

  AffirmationsHomeScreenFixture _setupFixture() {
    when(() => affirmationsBloc.authenticatedUser)
        .thenReturn(PositiveAffirmationsConsts.seedUser);
    return AffirmationsHomeScreenFixture(
      apptabBloc: apptabBloc,
      authBloc: authBloc,
      affirmationsBloc: affirmationsBloc,
    );
  }

  group('[AffirmationsHomeScreen]', () {
    group('[AppNavigator]', () {
      testWidgets('navigator tabs exist', (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
        await tester.pumpWidget(_setupFixture());

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

      testWidgets(
          'affirmations appbar title is rendered affirmations tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
        await tester.pumpWidget(_setupFixture());

        final widget = tester.widget<Text>(
            find.byKey(PositiveAffirmationsKeys.affirmationsAppbarTitle));

        expect(widget.data, 'Affirmations');
      });

      testWidgets('profile appbar title is rendered profile tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.profile);
        when(() => authBloc.state).thenReturn(AuthenticationState.authenticated(
            PositiveAffirmationsConsts.seedUser));
        await tester.pumpWidget(AffirmationsHomeScreenFixture(
          apptabBloc: apptabBloc,
          authBloc: authBloc,
        ));

        final widget = tester.widget<Text>(
            find.byKey(PositiveAffirmationsKeys.profileAppbarTitle));

        expect(widget.data, 'Profile');
      });

      testWidgets(
          'affirmations appbar add action is rendered affirmations tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
        await tester.pumpWidget(_setupFixture());

        expect(
          find.byKey(PositiveAffirmationsKeys.affirmationsAppBarAddButton),
          findsOneWidget,
        );
      });

      testWidgets('profile appbar edit action is rendered profile tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.profile);
        when(() => authBloc.state).thenReturn(AuthenticationState.authenticated(
            PositiveAffirmationsConsts.seedUser));
        await tester.pumpWidget(AffirmationsHomeScreenFixture(
          apptabBloc: apptabBloc,
          authBloc: authBloc,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys.profileAppbarEditButton),
          findsOneWidget,
        );
      });

      testWidgets(
          'affirmations list body is rendered when affirmations tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
        await tester.pumpWidget(_setupFixture());

        expect(
          find.byKey(PositiveAffirmationsKeys.affirmationsList),
          findsOneWidget,
        );
      });

      testWidgets('profile details body is rendered when profile tab selected',
          (tester) async {
        when(() => apptabBloc.state).thenReturn(AppTab.profile);
        when(() => authBloc.state).thenReturn(AuthenticationState.authenticated(
            PositiveAffirmationsConsts.seedUser));
        await tester.pumpWidget(AffirmationsHomeScreenFixture(
          apptabBloc: apptabBloc,
          authBloc: authBloc,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys.profileDetails),
          findsOneWidget,
        );
      });
    });
  });
}
