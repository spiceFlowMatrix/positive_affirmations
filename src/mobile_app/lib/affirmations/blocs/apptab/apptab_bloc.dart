import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apptab_event.dart';

enum AppTab { affirmations, profile }

class ApptabBloc extends Bloc<ApptabEvent, AppTab> {
  ApptabBloc() : super(AppTab.affirmations);

  @override
  Stream<AppTab> mapEventToState(
    ApptabEvent event,
  ) async* {
    if (event is TabUpdated) {
      if (event.tab != state) yield event.tab;
    }
  }
}
