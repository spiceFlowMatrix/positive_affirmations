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

class GraphicSelected extends ReaffirmationEvent {
  const GraphicSelected({required this.graphic});

  final ReaffirmationGraphic graphic;

  @override
  List<Object> get props => [graphic];
}

class ReaffirmationSubmitted extends ReaffirmationEvent {
  @override
  List<Object> get props => [];
}
