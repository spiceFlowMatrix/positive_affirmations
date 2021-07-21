part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class NameUpdated extends SignUpEvent {
  const NameUpdated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class NameSubmitted extends SignUpEvent {
  const NameSubmitted();
}

class NickNameUpdated extends SignUpEvent {
  const NickNameUpdated(this.nickName);

  final String nickName;

  @override
  List<Object> get props => [nickName];
}

class NickNameSubmitted extends SignUpEvent {
  const NickNameSubmitted();
}

class UserCreated extends SignUpEvent {}