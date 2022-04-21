part of 'sign_up_form_cubit.dart';

class SignUpFormState extends Equatable {
  const SignUpFormState({
    this.name = const PersonNameField.pure(),
    this.nickName = const NullablePersonNameField.pure(),
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.confirmPassword = const PasswordField.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
  });

  final PersonNameField name;
  final NullablePersonNameField nickName;
  final EmailField email;
  final PasswordField password;
  final PasswordField confirmPassword;
  final FormzStatus status;
  final String error;

  bool get passwordConfirmed => password.value == confirmPassword.value;

  SignUpFormState copyWith({
    PersonNameField? name,
    NullablePersonNameField? nickName,
    EmailField? email,
    PasswordField? password,
    PasswordField? confirmPassword,
    FormzStatus? status,
    String? error,
  }) {
    return SignUpFormState(
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        name,
        nickName,
        email,
        password,
        confirmPassword,
        status,
        error,
      ];
}
