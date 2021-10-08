part of 'affirmation_form_bloc.dart';

abstract class AffirmationFormEvent extends Equatable {
  const AffirmationFormEvent();
}

class TitleUpdated extends AffirmationFormEvent {
  const TitleUpdated(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class SubtitleUpdated extends AffirmationFormEvent {
  const SubtitleUpdated(this.subtitle);

  final String subtitle;

  @override
  List<Object?> get props => [subtitle];
}

class AffirmationSubmitted extends AffirmationFormEvent {
  @override
  List<Object?> get props => [];
}
