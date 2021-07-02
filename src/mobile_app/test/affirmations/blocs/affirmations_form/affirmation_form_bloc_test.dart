import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';
import 'package:mobile_app/affirmations/models/title_field.dart';

/// 4. valid subtitle supplied in SubtitleUpdated emits new state
/// 5. invalid subtitle supplied in SubtitleUpdated does not emit new state
/// 7. submit event emits new state only if form is valid

void main() {
  const String mockValidTitle = 'valid title';
  const String mockInvalidTitle = 'fwef47*';
  const String mockValidSubtitle = 'valid subtitle';
  const String mockInvalidSubtitle = 'invalid-subtitle**';

  late AffirmationFormBloc formBloc;
  late AffirmationFormBloc titleInitFormBloc;
  late AffirmationFormBloc subtitleInitFormBloc;

  setUp(() {
    formBloc = AffirmationFormBloc();
    titleInitFormBloc = AffirmationFormBloc(
      initialTitle: mockValidTitle,
    );
    subtitleInitFormBloc = AffirmationFormBloc(
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
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            subtitle: SubtitleField.dirty(mockValidSubtitle),
            status: FormzStatus.valid,
          ),
        ],
      );
      blocTest<AffirmationFormBloc, AffirmationFormState>(
        'supplying valid subtitle emits valid status',
        build: () => formBloc,
        act: (bloc) {
          bloc..add(SubtitleUpdated(mockInvalidSubtitle));
        },
        expect: () => <AffirmationFormState>[
          const AffirmationFormState(
            subtitle: SubtitleField.dirty(mockInvalidSubtitle),
            status: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
