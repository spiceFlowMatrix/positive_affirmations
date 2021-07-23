part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user = User.empty,
  });

  final User user;

  ProfileState copyWith({
    User? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [user];
}
