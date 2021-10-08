part of 'reaffirmation_bloc.dart';

enum ReaffirmationFormTab { note, font, stamp }

class ReaffirmationState extends Equatable {
  const ReaffirmationState({
    this.tab = ReaffirmationFormTab.note,
    this.value = const ReaffirmationValueField.pure(),
    this.font = const ReaffirmationFontField.pure(),
    this.stamp = const ReaffirmationStampField.pure(),
    this.submissionStatus = FormzStatus.pure,
  });

  final ReaffirmationFormTab tab;
  final ReaffirmationValueField value;
  final ReaffirmationFontField font;
  final ReaffirmationStampField stamp;
  final FormzStatus submissionStatus;

  ReaffirmationState copyWith({
    ReaffirmationFormTab? tab,
    ReaffirmationValueField? value,
    ReaffirmationFontField? font,
    ReaffirmationStampField? stamp,
    FormzStatus? submissionStatus,
  }) {
    return ReaffirmationState(
      tab: tab ?? this.tab,
      value: value ?? this.value,
      font: font ?? this.font,
      stamp: stamp ?? this.stamp,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [tab, value, font, stamp, submissionStatus];
}
