import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_font_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_graphic_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_value_field.dart';
import 'package:repository/repository.dart';

part 'reaffirmation_event.dart';
part 'reaffirmation_state.dart';

class ReaffirmationBloc extends Bloc<ReaffirmationEvent, ReaffirmationState> {
  ReaffirmationBloc() : super(ReaffirmationState()) {
    on<ValueSelected>(_onValueSelected);
    on<StampSelected>(_onGraphicSelected);
  }

  void _onValueSelected(
    ValueSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.value.value == event.value) {
      const value =
          const ReaffirmationValueField.dirty(ReaffirmationValue.empty);
      emit(state.copyWith(
        value: value,
        submissionStatus: Formz.validate([value, state.stamp]),
      ));
      return;
    }
    final value = ReaffirmationValueField.dirty(event.value);
    emit(state.copyWith(
      value: value,
      submissionStatus: Formz.validate([value, state.stamp]),
    ));
  }

  void _onGraphicSelected(
    StampSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.stamp.value == event.stamp) {
      final graphic = ReaffirmationStampField.dirty(ReaffirmationStamp.empty);
      emit(state.copyWith(
        stamp: graphic,
        submissionStatus: Formz.validate([state.value, graphic]),
      ));
      return;
    }
    final graphic = ReaffirmationStampField.dirty(event.stamp);
    emit(state.copyWith(
      stamp: graphic,
      submissionStatus: Formz.validate([state.value, graphic]),
    ));
  }
}
