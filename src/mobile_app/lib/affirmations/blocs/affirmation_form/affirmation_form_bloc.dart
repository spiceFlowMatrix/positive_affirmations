import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';
import 'package:mobile_app/affirmations/models/title_field.dart';
import 'package:mobile_app/models/affirmation.dart';

part 'affirmation_form_event.dart';

part 'affirmation_form_state.dart';

class AffirmationFormBloc
    extends Bloc<AffirmationFormEvent, AffirmationFormState> {
  AffirmationFormBloc({
    required this.affirmationsBloc,
    this.toUpdateAffirmation,
  }) : super(AffirmationFormState(
          title: toUpdateAffirmation != null
              ? TitleField.dirty(toUpdateAffirmation.title)
              : TitleField.pure(),
          subtitle: toUpdateAffirmation != null
              ? SubtitleField.dirty(toUpdateAffirmation.subtitle)
              : SubtitleField.pure(),
        ));

  final AffirmationsBloc affirmationsBloc;
  final Affirmation? toUpdateAffirmation;

  @override
  Stream<AffirmationFormState> mapEventToState(
    AffirmationFormEvent event,
  ) async* {
    if (event is TitleUpdated) {
      yield _mapTitleUpdatedToState(event, state);
    } else if (event is SubtitleUpdated) {
      yield _mapSubtitleUpdatedToState(event, state);
    } else if (event is AffirmationSubmitted) {
      yield* _mapAffirmationSubmittedToState(event, state);
    }
  }

  AffirmationFormState _mapTitleUpdatedToState(
      TitleUpdated event, AffirmationFormState state) {
    final title = TitleField.dirty(event.title);
    return state.copyWith(
      title: title,
      status: Formz.validate([
        title,
        state.subtitle,
      ]),
    );
  }

  AffirmationFormState _mapSubtitleUpdatedToState(
      SubtitleUpdated event, AffirmationFormState state) {
    final subtitle = SubtitleField.dirty(event.subtitle);
    return state.copyWith(
      subtitle: subtitle,
      status: Formz.validate([
        state.title,
        subtitle,
      ]),
    );
  }

  Stream<AffirmationFormState> _mapAffirmationSubmittedToState(
      AffirmationSubmitted event, AffirmationFormState state) async* {
    if (state.status == FormzStatus.valid) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      if (toUpdateAffirmation == null)
        affirmationsBloc
            .add(AffirmationCreated(state.title.value, state.subtitle.value));
      else
        affirmationsBloc.add(AffirmationUpdated(
            toUpdateAffirmation!.id, state.title.value, state.subtitle.value));

      yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }
}
