part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
  });

  final EmailField email;
  final PasswordField password;
  final FormzStatus status;
  final String error;

  SignInState copyWith({
    EmailField? email,
    PasswordField? password,
    FormzStatus? status,
    String? error,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [email, password, status, error];
}
