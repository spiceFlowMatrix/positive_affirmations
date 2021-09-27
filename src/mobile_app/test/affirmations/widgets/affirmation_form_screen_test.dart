import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';
import 'package:mobile_app/affirmations/models/title_field.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/affirmation.dart';

import '../../mocks/affirmation_form_bloc_mock.dart';
import '../../mocks/affirmations_bloc_mock.dart';
import '../fixtures/affirmation_form_screen_fixture.dart';

void main() {
  late AffirmationsBloc affirmationsBloc;
  late AffirmationFormBloc affirmationFormBloc;
  final Affirmation toUpdateAffirmation =
      PositiveAffirmationsRepositoryConsts.seedAffirmations[1];

  const String validTitleInput = 'valid title';
  const String invalidTitleInput = '!nv@l%dTitle';
  const String validSubtitleInput = 'valid subtitle';
  const String invalidSubtitleInput = '!nv@l%dSubtitle';

  setUpAll(() {
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<AffirmationFormState>(FakeAffirmationFormState());
    registerFallbackValue<AffirmationFormEvent>(FakeAffirmationFormEvent());
  });

  setUp(() {
    affirmationsBloc = MockAffirmationsBloc();
    affirmationFormBloc = MockAffirmationFormBloc();
  });

  AffirmationFormScreenFixture _buildNewForm() {
    when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState());
    return AffirmationFormScreenFixture(
      affirmationsBloc: affirmationsBloc,
      affirmationFormBloc: affirmationFormBloc,
    );
  }

  AffirmationFormScreenFixture _buildNewFormNoSetup() {
    return AffirmationFormScreenFixture(
      affirmationsBloc: affirmationsBloc,
      affirmationFormBloc: affirmationFormBloc,
    );
  }

  AffirmationFormScreenFixture _buildEditForm() {
    when(() => affirmationFormBloc.affirmationsBloc)
        .thenReturn(affirmationsBloc);
    when(() => affirmationFormBloc.toUpdateAffirmation)
        .thenReturn(toUpdateAffirmation);
    when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState(
      title: TitleField.dirty(toUpdateAffirmation.title),
      subtitle: SubtitleField.dirty(toUpdateAffirmation.subtitle),
    ));
    return AffirmationFormScreenFixture(
      affirmationsBloc: affirmationsBloc,
      affirmationFormBloc: affirmationFormBloc,
      toUpdateAffirmation: toUpdateAffirmation,
    );
  }

  group('[AffirmationFormScreen]', () {
    testWidgets('components exist for new affirmation form', (tester) async {
      await tester.pumpWidget(_buildNewForm());

      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormBackButton),
          findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.newAffirmationFormAppbarTitle),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.affirmationForm), findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormTitleField),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.affirmationFormTitleFieldLabel),
          findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormSubtitleField),
          findsOneWidget);
      expect(
          find.byKey(
              PositiveAffirmationsKeys.affirmationFormSubtitleFieldLabel),
          findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormSaveButton),
          findsOneWidget);
    });

    testWidgets('components exist for edit affirmation form', (tester) async {
      await tester.pumpWidget(_buildEditForm());

      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormBackButton),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.editAffirmationFormAppbarTitle),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.affirmationForm), findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormTitleField),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.affirmationFormTitleFieldLabel),
          findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormSubtitleField),
          findsOneWidget);
      expect(
          find.byKey(
              PositiveAffirmationsKeys.affirmationFormSubtitleFieldLabel),
          findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.affirmationFormSaveButton),
          findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys
              .affirmationFormDeactivateDeactivateButton(
                  '${toUpdateAffirmation.id}')),
          findsOneWidget);
    });

    group('Bloc Integration', () {
      testWidgets('title input triggers TitleUpdated event', (tester) async {
        await tester.pumpWidget(_buildNewForm());

        await tester.enterText(
          find.byKey(PositiveAffirmationsKeys.affirmationFormTitleField),
          validTitleInput,
        );

        verify(() => affirmationFormBloc.add(TitleUpdated(validTitleInput)))
            .called(1);
      });
      testWidgets('invalid title shows error', (tester) async {
        when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState(
          title: TitleField.dirty(invalidTitleInput),
          status: FormzStatus.invalid,
        ));
        await tester.pumpWidget(_buildNewFormNoSetup());

        expect(
          tester
              .widget<TextField>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormTitleField))
              .decoration!
              .errorText,
          equals(PositiveAffirmationsConsts.titleFieldInvalidError),
        );
      });
      testWidgets('empty title shows error when unpure', (tester) async {
        when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState(
          title: TitleField.dirty(''),
          status: FormzStatus.invalid,
        ));
        await tester.pumpWidget(_buildNewFormNoSetup());

        expect(
          tester
              .widget<TextField>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormTitleField))
              .decoration!
              .errorText,
          equals(PositiveAffirmationsConsts.titleFieldEmptyError),
        );
      });
      testWidgets('subtitle input triggers SubtitleTitleUpdated event',
          (tester) async {
        await tester.pumpWidget(_buildNewForm());

        await tester.enterText(
          find.byKey(PositiveAffirmationsKeys.affirmationFormSubtitleField),
          validSubtitleInput,
        );

        verify(() =>
                affirmationFormBloc.add(SubtitleUpdated(validSubtitleInput)))
            .called(1);
      });
      testWidgets('invalid subtitle shows error', (tester) async {
        when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState(
          subtitle: SubtitleField.dirty(invalidSubtitleInput),
          status: FormzStatus.invalid,
        ));
        await tester.pumpWidget(_buildNewFormNoSetup());

        expect(
          tester
              .widget<TextField>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormSubtitleField))
              .decoration!
              .errorText,
          equals(PositiveAffirmationsConsts.subtitleFieldInvalidError),
        );
      });
      testWidgets('submit button is disabled when form is invalid',
          (tester) async {
        when(() => affirmationFormBloc.state)
            .thenReturn(AffirmationFormState(status: FormzStatus.invalid));

        await tester.pumpWidget(_buildNewFormNoSetup());
        expect(
          tester
              .widget<ElevatedButton>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormSaveButton))
              .enabled,
          isFalse,
        );
      });
      testWidgets('submit button is disabled when form is pure',
          (tester) async {
        when(() => affirmationFormBloc.state)
            .thenReturn(AffirmationFormState(status: FormzStatus.pure));

        await tester.pumpWidget(_buildNewFormNoSetup());
        expect(
          tester
              .widget<ElevatedButton>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormSaveButton))
              .enabled,
          isFalse,
        );
      });
      testWidgets('submitting the form triggers AffirmationSubmitted',
          (tester) async {
        when(() => affirmationFormBloc.state).thenReturn(AffirmationFormState(
          title: TitleField.dirty(validTitleInput),
          subtitle: SubtitleField.dirty(validSubtitleInput),
          status: FormzStatus.valid,
        ));

        await tester.pumpWidget(_buildNewFormNoSetup());
        expect(
          tester
              .widget<ElevatedButton>(find
                  .byKey(PositiveAffirmationsKeys.affirmationFormSaveButton))
              .enabled,
          isTrue,
        );

        await tester.tap(
            find.byKey(PositiveAffirmationsKeys.affirmationFormSaveButton));

        verify(() => affirmationFormBloc.add(AffirmationSubmitted())).called(1);
      });
    });
  });
}
