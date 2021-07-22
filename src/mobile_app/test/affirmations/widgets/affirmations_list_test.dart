import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/nav_observer.dart';
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
  late PositiveAffirmationsNavigatorObserver navigatorObserver;

  setUpAll(() {
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<ApptabEvent>(FakeApptabEvent());
    registerFallbackValue<AppTab>(AppTab.affirmations);
  });

  AffirmationsHomeScreenFixture _buildFixture() {
    return AffirmationsHomeScreenFixture(
      apptabBloc: apptabBloc,
      authBloc: authBloc,
      affirmationsBloc: affirmationsBloc,
      navigatorObserver: navigatorObserver,
    );
  }

  group('[AffirmationsListEmpty]', () {
    setUp(() {
      apptabBloc = MockApptabBloc();
      authBloc = MockAuthenticationBloc();
      affirmationsBloc = MockAffirmationsBloc();
      navigatorObserver = PositiveAffirmationsNavigatorObserver();
      when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
      when(() => affirmationsBloc.state).thenReturn(AffirmationsState());
    });

    testWidgets('shows call to action when no affirmations exist',
        (tester) async {
      await tester.pumpWidget(_buildFixture());

      expect(
        find.byKey(PositiveAffirmationsKeys.noAffirmationsWarningBody),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.noAffirmationsWarningIcon),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.noAffirmationsWarningLabel),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.noAffirmationsWarningButton),
        findsOneWidget,
      );
    });

    testWidgets('pressing add navigates to affirmation form screen',
        (tester) async {
      var isAffirmationFormPushed = false;
      await tester.pumpWidget(_buildFixture());

      navigatorObserver.attachPushRouteObserver(
        AffirmationFormScreen.routeName,
        () {
          isAffirmationFormPushed = true;
        },
      );

      await tester.tap(
          find.byKey(PositiveAffirmationsKeys.noAffirmationsWarningButton));
      await tester.pumpAndSettle();

      expect(isAffirmationFormPushed, true);
    });
  });

  group('[AffirmationsList]', () {
    setUp(() {
      apptabBloc = MockApptabBloc();
      authBloc = MockAuthenticationBloc();
      affirmationsBloc = MockAffirmationsBloc();
      navigatorObserver = PositiveAffirmationsNavigatorObserver();
      when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
      when(() => affirmationsBloc.state).thenReturn(AffirmationsState(
          affirmations: PositiveAffirmationsConsts.seedAffirmations));
    });

    testWidgets('list items are generated equal to number of affirmations',
        (tester) async {
      await tester.pumpWidget(_buildFixture());

      final mockAffirmations = PositiveAffirmationsConsts.seedAffirmations;

      for (int i = 0; i < mockAffirmations.length; i++) {
        final itemKey = PositiveAffirmationsKeys.affirmationItem(
            '${mockAffirmations[i].id}');
        final itemTitleKey = PositiveAffirmationsKeys.affirmationItemTitle(
            mockAffirmations[i].id.toString());
        final itemSubtitleKey =
            PositiveAffirmationsKeys.affirmationItemSubtitle(
                mockAffirmations[i].id.toString());
        final itemLikeButtonKey =
            PositiveAffirmationsKeys.affirmationItemLikeButton(
                mockAffirmations[i].id.toString());
        final itemLikesKey = PositiveAffirmationsKeys.affirmationItemLikes(
            mockAffirmations[i].id.toString());
        final itemReaffirmationsKey =
            PositiveAffirmationsKeys.affirmationItemReaffirmationsCount(
                mockAffirmations[i].id.toString());
        final itemReaffirmButtonKey =
            PositiveAffirmationsKeys.affirmationItemReaffirmButton(
                mockAffirmations[i].id.toString());
        // final itemDeleteButtonKey =
        //     PositiveAffirmationsKeys.affirmationFormDeleteButton(
        //         '${element.id}');

        expect(find.byKey(itemKey), findsOneWidget);
        expect(find.byKey(itemTitleKey), findsOneWidget);
        expect(find.byKey(itemSubtitleKey), findsOneWidget);
        expect(find.byKey(itemLikeButtonKey), findsOneWidget);
        expect(find.byKey(itemLikesKey), findsOneWidget);
        expect(find.byKey(itemReaffirmationsKey), findsOneWidget);
        expect(find.byKey(itemReaffirmButtonKey), findsOneWidget);
        // expect(find.byKey(itemDeleteButtonKey), findsOneWidget);

        /* References:
        *   - https://stackoverflow.com/a/59043178
        *   - https://www.youtube.com/watch?v=pgMI5nmAem0
        * */
        final Size itemSize = tester.getSize(find.byKey(itemKey));
        await tester.drag(
          find.byKey(PositiveAffirmationsKeys.affirmationsList),
          Offset(0, -itemSize.height),
        );
        await tester.pump();
      }
    });
    testWidgets('pressing like button triggers like event', (tester) async {
      await tester.pumpWidget(_buildFixture());

      await tester.tap(
        find.byKey(
          PositiveAffirmationsKeys.affirmationItemLikeButton(
              '${PositiveAffirmationsConsts.seedAffirmations[0].id}'),
        ),
      );

      verify(() => affirmationsBloc.add(AffirmationLiked(
          PositiveAffirmationsConsts.seedAffirmations[0].id))).called(1);
    });

    // testWidgets('[Navigation] tapping an affirmation navigates details screen',
    //     (tester) async {
    //   var isAffirmationDetailsPushed = false;
    //   await tester.pumpWidget(_buildFixture());
    //
    //   navigatorObserver.attachPushRouteObserver(
    //     AffirmationDetailScreen.routeName,
    //     () {
    //       isAffirmationDetailsPushed = true;
    //     },
    //   );
    //
    //   await tester.tap(find.byKey(PositiveAffirmationsKeys.affirmationItem(
    //       '${PositiveAffirmationsConsts.seedAffirmations[1].id}')));
    //   await tester.pumpAndSettle();
    //
    //   expect(isAffirmationDetailsPushed, true);
    // });
    // testWidgets(
    //     '[Navigation] pressing back button returns to affirmations list',
    //     (tester) async {
    //   var isAffirmationDetailsPushed = false;
    //   var isAffirmationDetailsPopped = false;
    //   await tester.pumpWidget(_buildFixture());
    //
    //   navigatorObserver.attachPushRouteObserver(
    //     AffirmationDetailScreen.routeName,
    //     () {
    //       isAffirmationDetailsPushed = true;
    //     },
    //   );
    //   navigatorObserver.attachPopRouteObserver(
    //     AffirmationDetailScreen.routeName,
    //     () {
    //       isAffirmationDetailsPopped = true;
    //     },
    //   );
    //
    //   await tester.tap(find.byKey(PositiveAffirmationsKeys.affirmationItem(
    //       '${PositiveAffirmationsConsts.seedAffirmations[1].id}')));
    //   await tester.pumpAndSettle();
    //
    //   expect(isAffirmationDetailsPushed, true);
    //
    //   await tester.tap(find.byKey(
    //       PositiveAffirmationsKeys.affirmationDetailsBackButton(
    //           '${PositiveAffirmationsConsts.seedAffirmations[1].id}')));
    //   await tester.pumpAndSettle();
    //
    //   expect(isAffirmationDetailsPopped, true);
    // });

    group('[AppBar]', () {
      testWidgets('tapping the add action navigates affirmation form',
          (tester) async {
        var isAffirmationFormPushed = false;
        await tester.pumpWidget(_buildFixture());

        navigatorObserver.attachPushRouteObserver(
          AffirmationFormScreen.routeName,
          () {
            isAffirmationFormPushed = true;
          },
        );

        await tester.tap(
            find.byKey(PositiveAffirmationsKeys.affirmationsAppBarAddButton));
        await tester.pumpAndSettle();

        expect(isAffirmationFormPushed, true);
      });
    });
  });
}
