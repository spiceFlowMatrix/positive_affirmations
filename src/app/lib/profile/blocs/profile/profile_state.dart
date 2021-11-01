part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user = AppUser.empty,
    this.editStatus = FormzStatus.pure,
    this.editError = '',
    this.pictureUpdateStatus = FormzStatus.pure,
    this.pictureUpdateError = '',
    this.letters = const [],
    this.lettersLoadStatus = FormzStatus.pure,
    this.lettersLoadError = '',
  });

  final AppUser user;
  final FormzStatus editStatus;
  final String editError;
  final FormzStatus pictureUpdateStatus;
  final String pictureUpdateError;
  final List<Letter> letters;
  final FormzStatus lettersLoadStatus;
  final String lettersLoadError;

  static const String fieldUser = 'user';

  ProfileState copyWith({
    AppUser? user,
    FormzStatus? editStatus,
    String? editError,
    FormzStatus? pictureUpdateStatus,
    String? pictureUpdateError,
    List<Letter>? letters,
    FormzStatus? lettersLoadStatus,
    String? lettersLoadError,
  }) {
    return ProfileState(
      user: user ?? this.user,
      editStatus: editStatus ?? this.editStatus,
      editError: editError ?? this.editError,
      pictureUpdateStatus: pictureUpdateStatus ?? this.pictureUpdateStatus,
      pictureUpdateError: pictureUpdateError ?? this.pictureUpdateError,
      letters: letters ?? this.letters,
      lettersLoadStatus: lettersLoadStatus ?? this.lettersLoadStatus,
      lettersLoadError: lettersLoadError ?? this.lettersLoadError,
    );
  }

  @override
  List<Object> get props => [
        user,
        editStatus,
        editError,
        pictureUpdateStatus,
        pictureUpdateError,
        letters,
        lettersLoadStatus,
        lettersLoadError,
      ];
}
