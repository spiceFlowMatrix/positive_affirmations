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

class EmailUpdated extends SignUpEvent {
  const EmailUpdated({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordUpdated extends SignUpEvent {
  const PasswordUpdated({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordUpdated extends SignUpEvent {
  const ConfirmPasswordUpdated({
    required this.confirmPassword,
  });

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class AccountDetailsSubmitted extends SignUpEvent {}
