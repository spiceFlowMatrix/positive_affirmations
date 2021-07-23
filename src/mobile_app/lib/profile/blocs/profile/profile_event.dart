part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileEdited extends ProfileEvent {
  const ProfileEdited({
    required this.name,
    required this.nickName,
  });

  final String name;
  final String nickName;

  @override
  List<Object> get props => [name, nickName];
}
