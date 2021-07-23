import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileEdited) {
      yield _mapUserUpdatedToState(event, state);
    }
  }

  ProfileState _mapUserUpdatedToState(ProfileEdited event, ProfileState state) {
    final updatedUser = state.user.copyWith(
      name: event.name,
      nickName: event.nickName,
    );

    return state.copyWith(user: updatedUser);
  }
}

class HydratedProfileBloc extends ProfileBloc with HydratedMixin {
  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    final User? user = User.fromJson(json[ProfileState.fieldUser]);
    return ProfileState(user: user!);
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) => {
        ProfileState.fieldUser: state.user.fieldValues,
      };
}
