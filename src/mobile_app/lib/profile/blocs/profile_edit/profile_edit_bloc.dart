import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';

part 'profile_edit_event.dart';

part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc({required this.profileBloc})
      : super(ProfileEditState(
          name: NameField.dirty(profileBloc.state.user.name),
          nickName: NickNameField.dirty(profileBloc.state.user.nickName),
        ));

  final ProfileBloc profileBloc;

  @override
  Stream<ProfileEditState> mapEventToState(
    ProfileEditEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
