part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameField.pure(),
    this.nickName = const NickNameField.pure(),
    this.email = const EmailField.pure(),
    this.password = const PasswordField.pure(),
    this.confirmPassword = const PasswordField.pure(),
    this.nameStatus = FormzStatus.pure,
    this.nickNameStatus = FormzStatus.pure,
    this.emailStatus = FormzStatus.pure,
    this.passwordStatus = FormzStatus.pure,
    this.confirmPasswordStatus = FormzStatus.pure,
    this.submissionStatus = FormzStatus.pure,
    this.submissionError = '',
  });

  final NameField name;
  final NickNameField nickName;
  final EmailField email;
  final PasswordField password;
  final PasswordField confirmPassword;
  final FormzStatus nameStatus;
  final FormzStatus nickNameStatus;
  final FormzStatus emailStatus;
  final FormzStatus passwordStatus;
  final FormzStatus confirmPasswordStatus;
  final FormzStatus submissionStatus;
  final String submissionError;

  SignUpState copyWith({
    NameField? name,
    NickNameField? nickName,
    EmailField? email,
    PasswordField? password,
    PasswordField? confirmPassword,
    FormzStatus? nameStatus,
    FormzStatus? nickNameStatus,
    FormzStatus? emailStatus,
    FormzStatus? passwordStatus,
    FormzStatus? confirmPasswordStatus,
    FormzStatus? submissionStatus,
    String? submissionError,
  }) {
    return SignUpState(
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      nameStatus: nameStatus ?? this.nameStatus,
      nickNameStatus: nickNameStatus ?? this.nickNameStatus,
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      confirmPasswordStatus:
          confirmPasswordStatus ?? this.confirmPasswordStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      submissionError: submissionError ?? this.submissionError,
    );
  }

  /// NOTE: props MUST be defined as a non-nullable object list to avoid breaking tests
  @override
  List<Object> get props => [
        name,
        nickName,
        email,
        password,
        confirmPassword,
        nameStatus,
        nickNameStatus,
        emailStatus,
        passwordStatus,
        submissionStatus,
        submissionError,
      ];
}
