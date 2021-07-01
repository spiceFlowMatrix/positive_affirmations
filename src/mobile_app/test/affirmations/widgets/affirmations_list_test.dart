import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
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

  setUp(() {
    apptabBloc = MockApptabBloc();
    authBloc = MockAuthenticationBloc();
    affirmationsBloc = MockAffirmationsBloc();
    navigatorObserver = PositiveAffirmationsNavigatorObserver();
    when(() => apptabBloc.state).thenReturn(AppTab.affirmations);
    when(() => affirmationsBloc.state).thenReturn(AffirmationsState(
        affirmations: PositiveAffirmationsConsts.seedAffirmations));
  });

  AffirmationsHomeScreenFixture _buildFixture() {
    return AffirmationsHomeScreenFixture(
      apptabBloc: apptabBloc,
      authBloc: authBloc,
      affirmationsBloc: affirmationsBloc,
    );
  }

  group('[AffirmationsList]', () {
    testWidgets('list items are generated equal to number of affirmations',
        (tester) async {
      await tester.pumpWidget(_buildFixture());

      PositiveAffirmationsConsts.seedAffirmations.forEach((element) {
        final itemKey =
            PositiveAffirmationsKeys.affirmationItem(element.id.toString());
        final itemTitleKey = PositiveAffirmationsKeys.affirmationItemTitle(
            element.id.toString());
        final itemSubtitleKey =
            PositiveAffirmationsKeys.affirmationItemSubtitle(
                element.id.toString());
        final itemLikeButtonKey =
            PositiveAffirmationsKeys.affirmationItemLikeButton(
                element.id.toString());
        final itemLikesKey = PositiveAffirmationsKeys.affirmationItemLikes(
            element.id.toString());
        final itemReaffirmationsKey =
            PositiveAffirmationsKeys.affirmationItemReaffirmationsCount(
                element.id.toString());

        expect(find.byKey(itemKey), findsOneWidget);
        expect(find.byKey(itemTitleKey), findsOneWidget);
        expect(find.byKey(itemSubtitleKey), findsOneWidget);
        expect(find.byKey(itemLikeButtonKey), findsOneWidget);
        expect(find.byKey(itemLikesKey), findsOneWidget);
        expect(find.byKey(itemReaffirmationsKey), findsOneWidget);
      });
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
  });
}
