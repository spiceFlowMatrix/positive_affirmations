import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/affirmations/models/subtitle_field.dart';
import 'package:mobile_app/affirmations/models/title_field.dart';

part 'affirmation_form_event.dart';

part 'affirmation_form_state.dart';

class AffirmationFormBloc
    extends Bloc<AffirmationFormEvent, AffirmationFormState> {
  AffirmationFormBloc({
    this.initialTitle,
    this.initialSubtitle,
  }) : super(AffirmationFormState(
          title: initialTitle != null
              ? TitleField.dirty(initialTitle)
              : TitleField.pure(),
          subtitle: initialSubtitle != null
              ? SubtitleField.dirty(initialSubtitle)
              : SubtitleField.pure(),
        ));

  final String? initialTitle;
  final String? initialSubtitle;

  @override
  Stream<AffirmationFormState> mapEventToState(
    AffirmationFormEvent event,
  ) async* {
    if (event is TitleUpdated) {
      yield _mapTitleUpdatedToState(event, state);
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
}
