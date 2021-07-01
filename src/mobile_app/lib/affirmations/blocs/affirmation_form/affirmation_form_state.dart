part of 'affirmation_form_bloc.dart';

class AffirmationFormState extends Equatable {
  const AffirmationFormState({
    this.title: const TitleField.pure(),
    this.subtitle: const SubtitleField.pure(),
    this.status: FormzStatus.pure,
  });

  final TitleField title;
  final SubtitleField subtitle;
  final FormzStatus status;

  AffirmationFormState copyWith({
    TitleField? title,
    SubtitleField? subtitle,
    FormzStatus? status,
  }) {
    return AffirmationFormState();
  }

  @override
  List<Object> get props => [title, subtitle, status];
}
