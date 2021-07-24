import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/models/models.dart';
import 'package:repository/repository.dart';

part 'profile_edit_event.dart';

part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc({required this.userInitial})
      : super(ProfileEditState(
          name: NameField.dirty(userInitial.name),
          nickName: NickNameField.dirty(userInitial.nickName),
        ));

  final User userInitial;

  @override
  Stream<ProfileEditState> mapEventToState(
    ProfileEditEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
