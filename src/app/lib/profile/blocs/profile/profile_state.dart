part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user = AppUser.empty,
  });

  final AppUser user;

  static const String fieldUser = 'user';

  ProfileState copyWith({
    AppUser? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [user];
}
