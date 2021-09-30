part of 'reaffirmation_bloc.dart';

abstract class ReaffirmationEvent extends Equatable {
  const ReaffirmationEvent();
}

class ValueSelected extends ReaffirmationEvent {
  const ValueSelected({required this.value});

  final ReaffirmationValue value;

  @override
  List<Object> get props => [value];
}

class StampSelected extends ReaffirmationEvent {
  const StampSelected({required this.stamp});

  final ReaffirmationStamp stamp;

  @override
  List<Object> get props => [stamp];
}

class ReaffirmationSubmitted extends ReaffirmationEvent {
  @override
  List<Object> get props => [];
}
