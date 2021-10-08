part of 'profile_tab_bloc.dart';

abstract class ProfileTabEvent extends Equatable {
  const ProfileTabEvent();
}

class TabUpdated extends ProfileTabEvent {
  const TabUpdated(this.tab);

  final ProfileTab tab;

  @override
  List<Object> get props => [tab];
}
