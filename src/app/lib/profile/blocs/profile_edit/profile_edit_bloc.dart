import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:app/models/models.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';

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
    if (event is NameUpdated) {
      yield _mapNameUpdatedToState(event, state);
    } else if (event is NickNameUpdated) {
      yield _mapNickNameUpdatedToState(event, state);
    } else if (event is ProfileEditSubmitted) {
      yield* _mapProfileEditSubmittedToState(event, state);
    }
  }

  ProfileEditState _mapNameUpdatedToState(
      NameUpdated event, ProfileEditState state) {
    final name = NameField.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate(
        [
          name,
          state.nickName,
        ],
      ),
    );
  }

  ProfileEditState _mapNickNameUpdatedToState(
      NickNameUpdated event, ProfileEditState state) {
    final nickName = NickNameField.dirty(event.nickName);
    return state.copyWith(
      nickName: nickName,
      status: Formz.validate(
        [
          state.name,
          nickName,
        ],
      ),
    );
  }

  Stream<ProfileEditState> _mapProfileEditSubmittedToState(
      ProfileEditSubmitted event, ProfileEditState state) async* {
    if (state.status.isValid) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      profileBloc
        ..add(ProfileEdited(
          name: state.name.value,
          nickName: state.nickName.value,
        ));

      yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }
}
