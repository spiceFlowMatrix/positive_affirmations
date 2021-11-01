import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
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
    on<LetterCreationScheduleUpdated>(_mapLetterScheduleUpdatedToState);
    on<LettersLoaded>(_mapLettersLoadedToState);
    on<LoggedOut>(_mapLoggedOutToState);
    on<VerificationChecked>(_mapVerificationCheckedToState);
    _appUserSubscription = _userRepository.user.listen((user) {
      add(UserUpdated(user: user));
    });
  }

  final UserRepository _userRepository;
  late StreamSubscription<AppUser> _appUserSubscription;

  @override
  Future<void> close() {
    _appUserSubscription.cancel();
    _userRepository.disposeUser();
    return super.close();
  }

  void _mapUserCreatedToSate(UserCreated event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _mapUserUpdatedToState(UserUpdated event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: event.user));
  }

  Future<void> _mapProfileEditedToState(
      ProfileEdited event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(pictureUpdateStatus: FormzStatus.submissionInProgress));
    try {
      await _userRepository.editUser(
        name: event.name.trim(),
        nickName: event.nickName.trim(),
      );
      final updatedUser = state.user.copyWith(
        name: event.name.trim(),
        nickName: event.nickName.trim(),
      );
      emit(state.copyWith(
        pictureUpdateStatus: FormzStatus.submissionSuccess,
        pictureUpdateError: '',
        user: updatedUser,
      ));
    } catch (e) {
      emit(state.copyWith(
        pictureUpdateStatus: FormzStatus.submissionFailure,
        pictureUpdateError: e.toString(),
      ));
    }
  }

  Future<void> _mapPictureUpdatedToState(
      PictureUpdated event, Emitter<ProfileState> emit) async {
    await _userRepository.updateProfilePicture(event.pictureB64Enc);
  }

  Future<void> _mapLetterScheduleUpdatedToState(
      LetterCreationScheduleUpdated event, Emitter<ProfileState> emit) async {
    await _userRepository.updateLetterSchedule(event.schedule);
  }

  Future<void> _mapVerificationCheckedToState(
      VerificationChecked event, Emitter<ProfileState> emit) async {
    await _userRepository.checkIfVerified();
  }

  Future<void> _mapLettersLoadedToState(
      LettersLoaded event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      lettersLoadStatus: FormzStatus.submissionInProgress,
    ));
    try {
      final fetchedLetters = await _userRepository.getLetters();

      emit(state.copyWith(
        lettersLoadStatus: FormzStatus.submissionSuccess,
        lettersLoadError: '',
        letters: fetchedLetters,
      ));
    } catch (_) {
      emit(state.copyWith(
        lettersLoadStatus: FormzStatus.submissionFailure,
        lettersLoadError: _.toString(),
      ));
    }
  }

  Future<void> _mapLoggedOutToState(
      LoggedOut event, Emitter<ProfileState> emit) async {
    await _userRepository.logOut();
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
