part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameField.pure(),
    this.nickName = const NickNameField.pure(),
    this.email = const EmailField.pure(),
    this.nameStatus = FormzStatus.pure,
    this.nickNameStatus = FormzStatus.pure,
    this.emailStatus = FormzStatus.pure,
    this.createdUser = User.empty,
    this.submissionStatus = FormzStatus.pure,
  });

  final NameField name;
  final NickNameField nickName;
  final EmailField email;
  final FormzStatus nameStatus;
  final FormzStatus nickNameStatus;
  final FormzStatus emailStatus;
  final User createdUser;
  final FormzStatus submissionStatus;

  SignUpState copyWith({
    NameField? name,
    NickNameField? nickName,
    EmailField? email,
    FormzStatus? nameStatus,
    FormzStatus? nickNameStatus,
    FormzStatus? emailStatus,
    User? createdUser,
    FormzStatus? submissionStatus,
  }) {
    return SignUpState(
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      nameStatus: nameStatus ?? this.nameStatus,
      nickNameStatus: nickNameStatus ?? this.nickNameStatus,
      emailStatus: emailStatus ?? this.emailStatus,
      createdUser: createdUser ?? this.createdUser,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  /// props MUST be defined as a non-nullable object list to avoid breaking tests
  @override
  List<Object> get props => [
        name,
        nickName,
        email,
        nameStatus,
        nickNameStatus,
        emailStatus,
        createdUser,
        submissionStatus,
      ];
}
