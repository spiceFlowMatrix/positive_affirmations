import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/consts.dart';
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
    group('widget composition', () {
      testWidgets('top-level layout widgets are composed', (tester) async {
        forAffirmation = Affirmation.empty;
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
          find.byKey(
              PositiveAffirmationsKeys.reaffirmationFormScreenBackButton),
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

      testWidgets('top-level layout widgets are composed', (tester) async {
        forAffirmation = Affirmation.empty;
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));
        final noteTabWidget = tester.widget<Tab>(
            find.byKey(PositiveAffirmationsKeys.reaffirmationFormNoteTab));
        final fontTabWidget = tester.widget<Tab>(
            find.byKey(PositiveAffirmationsKeys.reaffirmationFormFontTab));
        final stampTabWidget = tester.widget<Tab>(
            find.byKey(PositiveAffirmationsKeys.reaffirmationFormStampTab));

        expect(noteTabWidget.child, isA<Text>());
        expect(fontTabWidget.child, isA<Text>());
        expect(stampTabWidget.child, isA<Text>());

        expect(
          (noteTabWidget.child as Text).data,
          equals(PositiveAffirmationsConsts.reaffirmationFormNoteTabTitle),
        );
        expect(
          (fontTabWidget.child as Text).data,
          equals(PositiveAffirmationsConsts.reaffirmationFormFontTabTitle),
        );
        expect(
          (stampTabWidget.child as Text).data,
          equals(PositiveAffirmationsConsts.reaffirmationFormStampTabTitle),
        );
      });

      testWidgets('preview panel shows no selection label', (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState());
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(
              PositiveAffirmationsKeys.reaffirmationFormPreviewPanelEmptyLabel),
          findsOneWidget,
        );
        final labelWidget = tester.widget<Text>(find.byKey(
            PositiveAffirmationsKeys.reaffirmationFormPreviewPanelEmptyLabel));
        expect(
          labelWidget.data,
          equals(PositiveAffirmationsConsts
              .reaffirmationFormPreviewPanelEmptyLabel),
        );
      });
      testWidgets('preview panel shows disabled submit button', (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState());
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys
              .reaffirmationFormPreviewPanelSubmitButton),
          findsOneWidget,
        );

        final buttonWidget = tester.widget<ElevatedButton>(find.byKey(
            PositiveAffirmationsKeys
                .reaffirmationFormPreviewPanelSubmitButton));
        expect(buttonWidget.enabled, isFalse);
        expect(buttonWidget.child, isA<Text>());
        expect(
          (buttonWidget.child as Text).data,
          equals(PositiveAffirmationsConsts
              .reaffirmationFormPreviewPanelSubmitButtonValue),
        );
      });
    });
  });
}
