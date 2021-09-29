part of 'reaffirmation_bloc.dart';

class ReaffirmationState extends Equatable {
  const ReaffirmationState({
    this.value = const ReaffirmationValueField.pure(),
    this.graphic = const ReaffirmationGraphicField.pure(),
    this.submissionStatus = FormzStatus.pure,
  });

  final ReaffirmationValueField value;
  final ReaffirmationGraphicField graphic;
  final FormzStatus submissionStatus;

  ReaffirmationState copyWith({
    ReaffirmationValueField? value,
    ReaffirmationGraphicField? graphic,
    FormzStatus? submissionStatus,
  }) {
    return ReaffirmationState(
      value: value ?? this.value,
      graphic: graphic ?? this.graphic,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [value, graphic, submissionStatus];
}
