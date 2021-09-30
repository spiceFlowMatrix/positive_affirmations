part of 'reaffirmation_bloc.dart';

abstract class ReaffirmationEvent extends Equatable {
  const ReaffirmationEvent();
}

class TabUpdated extends ReaffirmationEvent {
  const TabUpdated({required this.tab});

  final ReaffirmationFormTab tab;

  @override
  List<Object?> get props => [tab];
}

class ValueSelected extends ReaffirmationEvent {
  const ValueSelected({required this.value});

  final ReaffirmationValue value;

  @override
  List<Object> get props => [value];
}

class FontSelected extends ReaffirmationEvent {
  const FontSelected({required this.font});

  final ReaffirmationFont font;

  @override
  List<Object?> get props => [font];
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
