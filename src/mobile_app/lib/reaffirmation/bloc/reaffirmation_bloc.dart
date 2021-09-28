import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

part 'reaffirmation_event.dart';

part 'reaffirmation_state.dart';

class ReaffirmationBloc extends Bloc<ReaffirmationEvent, ReaffirmationState> {
  ReaffirmationBloc() : super(ReaffirmationState()) {
    on<ValueSelected>(_onValueSelected);
  }

  @override
  Stream<ReaffirmationState> mapEventToState(ReaffirmationEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  void _onValueSelected(ValueSelected value, Emitter<ReaffirmationState> emit) {
    emit(state.copyWith(value: value.value));
  }
}
