import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/consts.dart';
import 'package:app/nav_observer.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/affirmation.dart';

import '../../mocks/affirmations_bloc_mock.dart';
import '../fixtures/affirmation_detail_screen_fixture.dart';

void main() {
  final Affirmation mockAffirmation =
      PositiveAffirmationsRepositoryConsts.seedAffirmations[1];
  late AffirmationsBloc affirmationsBloc;
  late PositiveAffirmationsNavigatorObserver navigatorObserver;

  setUpAll(() {
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
  });

  setUp(() {
    affirmationsBloc = MockAffirmationsBloc();
    navigatorObserver = PositiveAffirmationsNavigatorObserver();
    when(() => affirmationsBloc.state).thenReturn(AffirmationsState(
        affirmations: PositiveAffirmationsRepositoryConsts.seedAffirmations));
  });

  group('[AffirmationDetailScreen]', () {
    testWidgets('all relevant widgets exist', (tester) async {
      await tester.pumpWidget(AffirmationDetailScreenFixture(
        affirmation: mockAffirmation,
        affirmationsBloc: affirmationsBloc,
        navigatorObserver: navigatorObserver,
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsAppbarTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsAppbarEditButton(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsBackButton(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsLikes(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(
            PositiveAffirmationsKeys.affirmationDetailsReaffirmationsCount(
                '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsReaffirmButton(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsSubtitle(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsTitle(
            '${mockAffirmation.id}')),
        findsOneWidget,
      );
    });

    // testWidgets('tapping edit button navigates to edit form', (tester) async {
    //   when(() => affirmationsBloc.state).thenReturn(AffirmationsState());
    //   var isAffirmationFormPushed = false;
    //   await tester.pumpWidget(AffirmationDetailScreenFixture(
    //     affirmation: mockAffirmation,
    //     affirmationsBloc: affirmationsBloc,
    //     navigatorObserver: navigatorObserver,
    //   ));
    //
    //   navigatorObserver.attachPushRouteObserver(
    //     '${AffirmationDetailScreen.routeName}${AffirmationFormScreen.routeName}',
    //     () {
    //       isAffirmationFormPushed = true;
    //     },
    //   );
    //
    //   await tester.tap(find.byKey(
    //       PositiveAffirmationsKeys.affirmationDetailsAppbarEditButton(
    //           '${mockAffirmation.id}')));
    //   await tester.pumpAndSettle();
    //
    //   expect(isAffirmationFormPushed, true);
    // });

    // testWidgets('pressing like button triggers like event', (tester) async {
    //   await tester.pumpWidget(AffirmationDetailScreenFixture(
    //     affirmation: mockAffirmation,
    //     affirmationsBloc: affirmationsBloc,
    //     navigatorObserver: navigatorObserver,
    //   ));
    //
    //   await tester.tap(
    //     find.byKey(
    //       PositiveAffirmationsKeys.affirmationDetailsLikeButton(
    //           '${mockAffirmation.id}'),
    //     ),
    //   );
    //
    //   verify(() => affirmationsBloc.add(AffirmationLiked(mockAffirmation.id)))
    //       .called(1);
    // });

    testWidgets('pressing reaffirm shows under construction snackbar',
        (tester) async {
      await tester.pumpWidget(AffirmationDetailScreenFixture(
        affirmation: mockAffirmation,
        affirmationsBloc: affirmationsBloc,
      ));

      // Reference for solution https://stackoverflow.com/a/65067950
      expect(
        find.byKey(PositiveAffirmationsKeys.underConstructionSnackbar),
        findsNothing,
      );
      expect(
        find.text(PositiveAffirmationsConsts.underConstructionSnackbarText),
        findsNothing,
      );
      await tester.tap(
        find.byKey(PositiveAffirmationsKeys.affirmationDetailsReaffirmButton(
            '${mockAffirmation.id}')),
      );
      await tester.pump();
      expect(
        find.byKey(PositiveAffirmationsKeys.underConstructionSnackbar),
        findsOneWidget,
      );
      expect(find.text('UNDER CONSTRUCTION'), findsOneWidget);
    });
  });
}
