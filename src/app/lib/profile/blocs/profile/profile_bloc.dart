import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ProfileState()) {
    _appUserSubscription = _userRepository.user.listen((user) {
      add(UserUpdated(user: user));
    });
  }

  final UserRepository _userRepository;
  late StreamSubscription<AppUser> _appUserSubscription;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is UserCreated) {
      yield _mapUserCreatedToSate(event, state);
    } else if (event is ProfileEdited) {
      yield _mapProfileEditedToState(event, state);
    } else if (event is UserUpdated) {
      yield _mapUserUpdatedToState(event, state);
    } else if (event is PictureUpdated) {
      yield _mapPictureUpdatedToState(event, state);
    }
  }

  @override
  Future<void> close() {
    _appUserSubscription.cancel();
    return super.close();
  }

  ProfileState _mapUserCreatedToSate(UserCreated event, ProfileState state) {
    return state.copyWith(user: event.user);
  }

  ProfileState _mapUserUpdatedToState(UserUpdated event, ProfileState state) {
    return state.copyWith(user: event.user);
  }

  ProfileState _mapProfileEditedToState(
      ProfileEdited event, ProfileState state) {
    final updatedUser = state.user.copyWith(
      name: event.name.trim(),
      nickName: event.nickName.trim(),
    );

    return state.copyWith(user: updatedUser);
  }

  ProfileState _mapPictureUpdatedToState(
      PictureUpdated event, ProfileState state) {
    final updatedUser = state.user.copyWith(
      pictureB64Enc: event.pictureB64Enc,
    );

    return state.copyWith(user: updatedUser);
  }
}

class HydratedProfileBloc extends ProfileBloc with HydratedMixin {
  HydratedProfileBloc({required UserRepository userRepository})
      : super(userRepository: userRepository);

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    final AppUser? user = AppUser.fromJson(json[ProfileState.fieldUser]);
    return ProfileState(user: user!);
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) => {
        ProfileState.fieldUser: state.user.fieldValues,
      };
}
