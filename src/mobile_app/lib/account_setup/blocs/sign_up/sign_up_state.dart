part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameField.pure(),
    this.nickName = const NickNameField.pure(),
    this.nameStatus = FormzStatus.pure,
    this.nickNameStatus = FormzStatus.pure,
  });

  final NameField name;
  final NickNameField nickName;
  final FormzStatus nameStatus;
  final FormzStatus nickNameStatus;

  @override
  List<Object?> get props => [name, nickName, nameStatus, nickNameStatus];
}
