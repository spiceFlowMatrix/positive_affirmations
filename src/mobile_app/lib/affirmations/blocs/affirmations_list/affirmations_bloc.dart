import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/models.dart';

part 'affirmations_event.dart';
part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  AffirmationsBloc() : super(AffirmationsState());

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
