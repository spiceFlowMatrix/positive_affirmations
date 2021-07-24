part of 'profile_edit_bloc.dart';

abstract class ProfileEditEvent extends Equatable {
  const ProfileEditEvent();
}

class NameUpdated extends ProfileEditEvent {
  const NameUpdated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class NickNameUpdated extends ProfileEditEvent {
  const NickNameUpdated(this.nickName);

  final String nickName;

  @override
  List<Object> get props => [nickName];
}

class ProfileEditSubmitted extends ProfileEditEvent {
  @override
  List<Object> get props => [];
}
