import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../mocks/affirmations_bloc_mock.dart';
import '../../mocks/reaffirmation_bloc_mock.dart';
import '../fixtures/reaffirmation_form_screen_fixture.dart';

void main() {
  late ReaffirmationBloc reaffirmationBloc;
  late AffirmationsBloc affirmationsBloc;
  late Affirmation forAffirmation;

  setUpAll(() {
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<ReaffirmationState>(FakeReaffirmationState());
    registerFallbackValue<ReaffirmationEvent>(FakeReaffirmationEvent());
  });

  setUp(() {
    reaffirmationBloc = MockReaffirmationBloc();
    affirmationsBloc = MockAffirmationsBloc();
  });

  group('[ReaffirmationFormScreen]', () {
    testWidgets('layout widgets are composed', (tester) async {
      forAffirmation = Affirmation.empty;
      when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState());
      when(() => affirmationsBloc.state).thenReturn(AffirmationsState());
      await tester.pumpWidget(ReaffirmationFormScreenFixture(
        reaffirmationBloc: reaffirmationBloc,
        affirmationsBloc: affirmationsBloc,
        forAffirmation: forAffirmation,
      ));
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormScreenTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormScreen),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormScreenBackButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormNoteTab),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormFontTab),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.reaffirmationFormStampTab),
        findsOneWidget,
      );
    });
  });
}
