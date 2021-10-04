import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_graphic_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_value_field.dart';
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
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState());
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
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState());
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

      testWidgets('preview panel shows no selection label when state is fresh',
          (tester) async {
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
      testWidgets(
          'preview panel shows disabled submit button when state is fresh',
          (tester) async {
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

      testWidgets('note options are displayed when [note] tab is selected',
          (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.note,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys.reaffirmationFormNoteTabBody),
          findsOneWidget,
        );
        expect(
          find.byKey(PositiveAffirmationsKeys.reaffirmationFormNoteTabBodyList),
          findsOneWidget,
        );

        ReaffirmationValue.values.forEach((value) {
          expect(
            find.byKey(
                PositiveAffirmationsKeys.reaffirmationFormNoteTabBodyListItem(
                    value.index)),
            findsOneWidget,
          );
        });
      });
      testWidgets('font options are displayed when [font] tab is selected',
          (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.font,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys.reaffirmationFormFontTabBody),
          findsOneWidget,
        );
        expect(
          find.byKey(PositiveAffirmationsKeys.reaffirmationFormFontTabBodyList),
          findsOneWidget,
        );

        ReaffirmationValue.values.forEach((value) {
          expect(
            find.byKey(
                PositiveAffirmationsKeys.reaffirmationFormFontTabBodyListItem(
                    value.index)),
            findsOneWidget,
          );
        });
      });
      testWidgets('stamp options are displayed when [stamp] tab is selected',
          (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.stamp,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys.reaffirmationFormStampTabBody),
          findsOneWidget,
        );
        expect(
          find.byKey(
              PositiveAffirmationsKeys.reaffirmationFormStampTabBodyList),
          findsOneWidget,
        );

        ReaffirmationValue.values.forEach((value) {
          expect(
            find.byKey(
                PositiveAffirmationsKeys.reaffirmationFormStampTabBodyListItem(
                    value.index)),
            findsOneWidget,
          );
        });
      });
    });

    group('[NOTE tab]', () {
      testWidgets('tapping note option triggers state event', (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.note,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        await tester.tap(find.byKey(
            PositiveAffirmationsKeys.reaffirmationFormNoteTabBodyListItem(
                ReaffirmationValue.loveIt.index)));

        verify(() => reaffirmationBloc
          ..add(ValueSelected(value: ReaffirmationValue.loveIt))).called(1);
      });
    });

    group('[FONT tab]', () {
      testWidgets('tapping font option triggers state event', (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.font,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        await tester.tap(find.byKey(
            PositiveAffirmationsKeys.reaffirmationFormFontTabBodyListItem(
                ReaffirmationFont.birthstone.index)));

        verify(() => reaffirmationBloc
          ..add(FontSelected(font: ReaffirmationFont.birthstone))).called(1);
      });
    });

    group('[STAMP tab]', () {
      testWidgets('tapping stamp option triggers state event', (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          tab: ReaffirmationFormTab.stamp,
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        await tester.tap(find.byKey(
            PositiveAffirmationsKeys.reaffirmationFormStampTabBodyListItem(
                ReaffirmationStamp.takeOff.index)));

        verify(() => reaffirmationBloc
          ..add(StampSelected(stamp: ReaffirmationStamp.takeOff))).called(1);
      });
    });

    group('[Preview Panel]', () {
      testWidgets('preview text is displayed when note and stamp are selected',
          (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          submissionStatus: FormzStatus.valid,
          value: ReaffirmationValueField.dirty(ReaffirmationValue.goodWork),
          stamp: ReaffirmationStampField.dirty(ReaffirmationStamp.medal),
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        expect(
          find.byKey(PositiveAffirmationsKeys
              .reaffirmationFormPreviewPanelSelectedNote),
          findsOneWidget,
        );
        expect(
          find.byKey(PositiveAffirmationsKeys
              .reaffirmationFormPreviewPanelSelectedStamp),
          findsOneWidget,
        );
        expect(
          find.byKey(
              PositiveAffirmationsKeys.reaffirmationFormPreviewPanelEmptyLabel),
          findsNothing,
        );

        final selectedNote = tester.widget<Text>(find.byKey(
            PositiveAffirmationsKeys
                .reaffirmationFormPreviewPanelSelectedNote));
        final selectedStamp = tester.widget<Text>(find.byKey(
            PositiveAffirmationsKeys
                .reaffirmationFormPreviewPanelSelectedStamp));
        final reaffirmButton = tester.widget<ElevatedButton>(find.byKey(
            PositiveAffirmationsKeys
                .reaffirmationFormPreviewPanelSubmitButton));

        expect(
          selectedNote.data,
          equals(PositiveAffirmationsConsts.reaffirmationNoteValue(
              ReaffirmationValue.goodWork)),
        );
        expect(
          selectedNote.style?.fontFamily,
          equals(PositiveAffirmationsConsts.reaffirmationFontValue(
              reaffirmationBloc.state.font.value)),
        );
        expect(
            selectedStamp.data,
            PositiveAffirmationsConsts.reaffirmationStampValue(
                    ReaffirmationStamp.medal)
                .values
                .toList()[0]);
        expect(reaffirmButton.enabled, equals(true));
      });

      testWidgets(
          'verify that submit button triggers reaffirmation creation event',
          (tester) async {
        forAffirmation = Affirmation.empty;
        when(() => reaffirmationBloc.state).thenReturn(ReaffirmationState(
          submissionStatus: FormzStatus.valid,
          value: ReaffirmationValueField.dirty(ReaffirmationValue.goodWork),
          stamp: ReaffirmationStampField.dirty(ReaffirmationStamp.medal),
        ));
        await tester.pumpWidget(ReaffirmationFormScreenFixture(
          reaffirmationBloc: reaffirmationBloc,
          affirmationsBloc: affirmationsBloc,
          forAffirmation: forAffirmation,
        ));

        await tester.tap(find.byKey(PositiveAffirmationsKeys
            .reaffirmationFormPreviewPanelSubmitButton));

        verify(() => affirmationsBloc.add(ReaffirmationCreated(
              affirmationId: forAffirmation.id,
              value: reaffirmationBloc.state.value.value,
              font: reaffirmationBloc.state.font.value,
              stamp: reaffirmationBloc.state.stamp.value,
            ))).called(1);
      });
    });
  });
}
