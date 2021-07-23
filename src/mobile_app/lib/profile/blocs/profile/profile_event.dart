part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileUpdated extends ProfileEvent {
  const ProfileUpdated({required this.toUpdateUser});

  final User toUpdateUser;

  @override
  List<Object> get props => [toUpdateUser];
}
