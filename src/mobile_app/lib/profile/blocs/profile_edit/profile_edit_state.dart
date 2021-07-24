part of 'profile_edit_bloc.dart';

class ProfileEditState extends Equatable {
  const ProfileEditState({
    this.name = const NameField.pure(),
    this.nickName = const NickNameField.pure(),
    this.status = FormzStatus.pure,
  });

  final NameField name;
  final NickNameField nickName;
  final FormzStatus status;

  static const String fieldName = 'name';
  static const String fieldNickName = 'nickName';

  ProfileEditState copyWith({
    NameField? name,
    NickNameField? nickName,
    FormzStatus? status,
  }) {
    return ProfileEditState(
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, nickName, status];
}
