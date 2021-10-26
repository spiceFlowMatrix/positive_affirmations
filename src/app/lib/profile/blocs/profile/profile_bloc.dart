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
    on<UserCreated>(_mapUserCreatedToSate);
    on<ProfileEdited>(_mapProfileEditedToState);
    on<UserUpdated>(_mapUserUpdatedToState);
    on<PictureUpdated>(_mapPictureUpdatedToState);
    _appUserSubscription = _userRepository.user.listen((user) {
      add(UserUpdated(user: user));
    });
  }

  final UserRepository _userRepository;
  late StreamSubscription<AppUser> _appUserSubscription;

  @override
  Future<void> close() {
    _appUserSubscription.cancel();
    return super.close();
  }

  void _mapUserCreatedToSate(UserCreated event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _mapUserUpdatedToState(UserUpdated event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _mapProfileEditedToState(
      ProfileEdited event, Emitter<ProfileState> emit) {
    final updatedUser = state.user.copyWith(
      name: event.name.trim(),
      nickName: event.nickName.trim(),
    );

    emit(state.copyWith(user: updatedUser));
  }

  void _mapPictureUpdatedToState(
      PictureUpdated event, Emitter<ProfileState> emit) {
    final updatedUser = state.user.copyWith(
      pictureB64Enc: event.pictureB64Enc,
    );

    emit(state.copyWith(user: updatedUser));
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
