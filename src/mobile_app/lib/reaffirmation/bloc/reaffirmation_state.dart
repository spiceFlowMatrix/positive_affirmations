part of 'reaffirmation_bloc.dart';

class ReaffirmationState extends Equatable {
  const ReaffirmationState({
    this.value = ReaffirmationValue.empty,
    this.graphic = ReaffirmationGraphic.empty,
    this.submissionStatus = FormzStatus.pure,
  });

  final ReaffirmationValue value;
  final ReaffirmationGraphic graphic;
  final FormzStatus submissionStatus;

  ReaffirmationState copyWith({
    ReaffirmationValue? value,
    ReaffirmationGraphic? graphic,
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
