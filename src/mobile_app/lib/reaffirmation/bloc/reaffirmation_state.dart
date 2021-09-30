part of 'reaffirmation_bloc.dart';

class ReaffirmationState extends Equatable {
  const ReaffirmationState({
    this.value = const ReaffirmationValueField.pure(),
    this.stamp = const ReaffirmationStampField.pure(),
    this.submissionStatus = FormzStatus.pure,
  });

  final ReaffirmationValueField value;
  final ReaffirmationStampField stamp;
  final FormzStatus submissionStatus;

  ReaffirmationState copyWith({
    ReaffirmationValueField? value,
    ReaffirmationStampField? stamp,
    FormzStatus? submissionStatus,
  }) {
    return ReaffirmationState(
      value: value ?? this.value,
      stamp: stamp ?? this.stamp,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [value, stamp, submissionStatus];
}
