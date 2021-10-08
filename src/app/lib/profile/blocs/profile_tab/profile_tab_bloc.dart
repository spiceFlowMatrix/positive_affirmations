import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_tab_event.dart';

enum ProfileTab { affirmations, letters }

class ProfileTabBloc extends Bloc<ProfileTabEvent, ProfileTab> {
  ProfileTabBloc() : super(ProfileTab.affirmations);

  @override
  Stream<ProfileTab> mapEventToState(
    ProfileTabEvent event,
  ) async* {
    if (event is TabUpdated) {
      if (event.tab != state) yield event.tab;
    }
  }
}
