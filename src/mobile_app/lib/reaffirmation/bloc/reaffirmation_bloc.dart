import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

part 'reaffirmation_event.dart';
part 'reaffirmation_state.dart';

class ReaffirmationBloc extends Bloc<ReaffirmationEvent, ReaffirmationState> {
  ReaffirmationBloc() : super(ReaffirmationState()) {
    on<ValueSelected>(_onValueSelected);
    on<GraphicSelected>(_onGraphicSelected);
  }

  void _onValueSelected(
    ValueSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.value == event.value) {
      emit(state.copyWith(value: ReaffirmationValue.empty));
      return;
    }
    emit(state.copyWith(value: event.value));
  }

  void _onGraphicSelected(
    GraphicSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.graphic == event.graphic) {
      emit(state.copyWith(graphic: ReaffirmationGraphic.empty));
      return;
    }
    emit(state.copyWith(graphic: event.graphic));
  }
}
