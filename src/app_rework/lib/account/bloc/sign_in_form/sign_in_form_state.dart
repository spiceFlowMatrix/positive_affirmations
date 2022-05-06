part of 'sign_in_form_cubit.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
  });

  final EmailField email;
  final PasswordField password;
  final FormzStatus status;
  final String error;

  SignInFormState copyWith({
    EmailField? email,
    PasswordField? password,
    FormzStatus? status,
    String? error,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [email, password, status, error];
}
