import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void updateName(String newName) {
    final name = NameField.dirty(newName);

    emit(state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    ));
  }

  void submitName() {
    if (state.name.invalid) return;

    return emit(state.copyWith(
      name: NameField.dirty(state.name.value.trim()),
      nameStatus: FormzStatus.submissionSuccess,
    ));
  }

  void updateNickName(String newNickname) {
    if (state.name.pure ||
        state.name.invalid ||
        !state.nameStatus.isSubmissionSuccess) return;

    final nickName = NickNameField.dirty(newNickname);

    emit(state.copyWith(
      nickName: nickName,
      nickNameStatus: Formz.validate([nickName]),
    ));
  }

  void submitNickName() {
    if (state.nickName.invalid) return;

    return emit(state.copyWith(
      nickName: NickNameField.dirty(state.nickName.value.trim()),
      nickNameStatus: FormzStatus.submissionSuccess,
    ));
  }

  void backNickName() {
    emit(state.copyWith(
      nameStatus: FormzStatus.pure,
    ));
  }

  void updateEmail(String newEmail) {
    final email = EmailField.dirty(newEmail);

    emit(state.copyWith(
      email: email,
      emailStatus: Formz.validate([email]),
    ));
  }

  void updatePassword(String newPassword) {
    final password = PasswordField.dirty(newPassword);

    emit(state.copyWith(
      password: password,
      passwordStatus: Formz.validate([password]),
      confirmPasswordStatus: FormzStatus.invalid,
    ));
  }

  void updateConfirmPassword(String newPassword) {
    final confirmPassword = PasswordField.dirty(newPassword);

    emit(state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordStatus: state.password.value == confirmPassword.value
          ? FormzStatus.valid
          : FormzStatus.invalid,
    ));
  }

  void backAccountDetails() {
    emit(state.copyWith(
      nickNameStatus: FormzStatus.pure,
    ));
  }
}
