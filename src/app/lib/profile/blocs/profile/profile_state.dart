part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user = AppUser.empty,
    this.editStatus = FormzStatus.pure,
    this.editError = '',
    this.pictureUpdateStatus = FormzStatus.pure,
    this.pictureUpdateError = '',
  });

  final AppUser user;
  final FormzStatus editStatus;
  final String editError;
  final FormzStatus pictureUpdateStatus;
  final String pictureUpdateError;

  static const String fieldUser = 'user';

  ProfileState copyWith({
    AppUser? user,
    FormzStatus? editStatus,
    String? editError,
    FormzStatus? pictureUpdateStatus,
    String? pictureUpdateError,
  }) {
    return ProfileState(
      user: user ?? this.user,
      editStatus: editStatus ?? this.editStatus,
      editError: editError ?? this.editError,
      pictureUpdateStatus: pictureUpdateStatus ?? this.pictureUpdateStatus,
      pictureUpdateError: pictureUpdateError ?? this.pictureUpdateError,
    );
  }

  @override
  List<Object> get props => [
        user,
        editStatus,
        editError,
        pictureUpdateStatus,
        pictureUpdateError,
      ];
}
