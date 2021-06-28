import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/models.dart';

part 'affirmations_list_event.dart';
part 'affirmations_list_state.dart';

class AffirmationsListBloc extends Bloc<AffirmationsListEvent, AffirmationsListState> {
  AffirmationsListBloc() : super(AffirmationsListLoadInProgress());

  @override
  Stream<AffirmationsListState> mapEventToState(
    AffirmationsListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
