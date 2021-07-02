import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';
import 'package:mobile_app/affirmations/models/title_field.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/affirmations_bloc_mock.dart';

/// 7. submit event emits new state only if form is valid

void main() {
  const String mockValidTitle = 'valid title';
  const String mockInvalidTitle = 'fwef47*';
  const String mockValidSubtitle = 'valid subtitle';
  const String mockInvalidSubtitle = 'invalid-subtitle**';

  late AffirmationsBloc affirmationsBloc;
  late AffirmationFormBloc formBloc;
  late AffirmationFormBloc titleInitFormBloc;
  late AffirmationFormBloc subtitleInitFormBloc;

  setUpAll(() {
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
  });

  setUp(() {
    affirmationsBloc = MockAffirmationsBloc();
    formBloc = AffirmationFormBloc(affirmationsBloc: affirmationsBloc);
    titleInitFormBloc = AffirmationFormBloc(
      affirmationsBloc: affirmationsBloc,
      initialTitle: mockValidTitle,
    );
    subtitleInitFormBloc = AffirmationFormBloc(
      affirmationsBloc: affirmationsBloc,
      initialSubtitle: mockValidSubtitle,
    );
  });

  group('[AffirmationFormBloc]', () {
    test('initial state is AffirmationFormState', () {
      expect(formBloc.state, AffirmationFormState());
    });
    test('initial state supplied dirty title', () {
      expect(
        titleInitFormBloc.state,
        AffirmationFormState(title: TitleField.dirty(mockValidTitle)),
      );
    });
    test('initial state supplied dirty subtitle', () {
      expect(
        subtitleInitFormBloc.state,
        AffirmationFormState(
          subtitle: SubtitleField.dirty(mockValidSubtitle),
        ),
      );
    });

    group('[TitleUpdated]', () {
      blocTest<AffirmationFormBloc, AffirmationFormState>(
        'supplying valid title emits valid status',
        build: () => formBloc,
        act: (bloc) {
          bloc..add(TitleUpdated(mockValidTitle));
        },
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            title: TitleField.dirty(mockValidTitle),
            status: FormzStatus.valid,
          ),
        ],
      );
      blocTest<AffirmationFormBloc, AffirmationFormState>(
        'supplying invalid title emits invalid status',
        build: () => formBloc,
        act: (bloc) {
          bloc..add(TitleUpdated(mockInvalidTitle));
        },
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            title: TitleField.dirty(mockInvalidTitle),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[SubtitleUpdated]', () {
      blocTest<AffirmationFormBloc, AffirmationFormState>(
        'supplying valid subtitle emits valid status',
        build: () => formBloc,
        act: (bloc) {
          bloc..add(SubtitleUpdated(mockValidSubtitle));
        },
        seed: () => AffirmationFormState(
          title: TitleField.dirty(mockValidTitle),
          status: FormzStatus.valid,
        ),
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            title: TitleField.dirty(mockValidTitle),
            subtitle: SubtitleField.dirty(mockValidSubtitle),
            status: FormzStatus.valid,
          ),
        ],
      );
      blocTest<AffirmationFormBloc, AffirmationFormState>(
        'supplying invalid subtitle emits invalid status',
        build: () => formBloc,
        act: (bloc) {
          bloc..add(SubtitleUpdated(mockInvalidSubtitle));
        },
        seed: () => AffirmationFormState(
          title: TitleField.dirty(mockValidTitle),
          status: FormzStatus.valid,
        ),
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            title: TitleField.dirty(mockValidTitle),
            subtitle: SubtitleField.dirty(mockInvalidSubtitle),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });

    group('[AffirmationSubmitted]', () {
      blocTest<AffirmationFormBloc, AffirmationFormState>(
          'affirmation is not created if form state is invalid',
          build: () => formBloc,
          seed: () => AffirmationFormState(
                title: TitleField.dirty(mockInvalidTitle),
                subtitle: SubtitleField.dirty(mockInvalidSubtitle),
                status: FormzStatus.invalid,
              ),
          act: (bloc) {
            bloc..add(AffirmationSubmitted());
          },
          verify: (_) {
            verifyNever(() => affirmationsBloc.add(
                AffirmationCreated(mockInvalidTitle, mockInvalidSubtitle)));
          });
      blocTest<AffirmationFormBloc, AffirmationFormState>(
          'affirmation is only created if form state is valid',
          build: () => formBloc,
          seed: () => AffirmationFormState(
                title: TitleField.dirty(mockValidTitle),
                subtitle: SubtitleField.dirty(mockValidSubtitle),
                status: FormzStatus.valid,
              ),
          act: (bloc) {
            bloc..add(AffirmationSubmitted());
          },
          verify: (_) {
            verify(() => affirmationsBloc
                    .add(AffirmationCreated(mockValidTitle, mockValidSubtitle)))
                .called(1);
          });
    });
  });
}
