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
    on<TabUpdated>(_onTabUpdated);
    on<ValueSelected>(_onValueSelected);
    on<FontSelected>(_onFontSelected);
    on<StampSelected>(_onGraphicSelected);
  }

  void _onTabUpdated(
    TabUpdated event,
    Emitter<ReaffirmationState> emit,
  ) {
    emit(state.copyWith(tab: event.tab));
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
        submissionStatus: Formz.validate([value, state.font, state.stamp]),
      ));
      return;
    }
    final value = ReaffirmationValueField.dirty(event.value);
    emit(state.copyWith(
      value: value,
      submissionStatus: Formz.validate([value, state.font, state.stamp]),
    ));
  }

  void _onFontSelected(
    FontSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.font.value == event.font) {
      final font = ReaffirmationFontField.dirty(ReaffirmationFont.none);
      emit(state.copyWith(
        font: font,
        submissionStatus: Formz.validate([state.value, font, state.stamp]),
      ));
      return;
    }
    final font = ReaffirmationFontField.dirty(event.font);
    emit(state.copyWith(
      font: font,
      submissionStatus: Formz.validate([state.value, font, state.stamp]),
    ));
  }

  void _onGraphicSelected(
    StampSelected event,
    Emitter<ReaffirmationState> emit,
  ) {
    if (state.stamp.value == event.stamp) {
      final stamp = ReaffirmationStampField.dirty(ReaffirmationStamp.empty);
      emit(state.copyWith(
        stamp: stamp,
        submissionStatus: Formz.validate([state.value, state.font, stamp]),
      ));
      return;
    }
    final stamp = ReaffirmationStampField.dirty(event.stamp);
    emit(state.copyWith(
      stamp: stamp,
      submissionStatus: Formz.validate([state.value, state.font, stamp]),
    ));
  }
}
