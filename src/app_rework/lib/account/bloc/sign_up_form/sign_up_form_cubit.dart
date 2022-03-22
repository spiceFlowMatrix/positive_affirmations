import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/models/form_fields/email_field.dart';
import 'package:positive_affirmations/models/form_fields/nullable_person_name_field.dart';
import 'package:positive_affirmations/models/form_fields/password_field.dart';
import 'package:positive_affirmations/models/form_fields/person_name_field.dart';

part 'sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState());

  void updateName(String newName) {
    final name = PersonNameField.dirty(newName);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.nickName,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void updateNickname(String? newNickName) {
    final nickName = NullablePersonNameField.dirty(newNickName);
    emit(state.copyWith(
      nickName: nickName,
      status: Formz.validate([
        state.name,
        nickName,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void updateEmail(String newEmail) {
    final email = EmailField.dirty(newEmail);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.name,
        state.nickName,
        email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void updatePassword(String newPassword) {
    final password = PasswordField.dirty(newPassword);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.name,
        state.nickName,
        state.email,
        password,
        state.confirmPassword,
      ]),
    ));
  }

  void updateConfirmPassword(String newConfirmPassword) {
    final confirmPassword = PasswordField.dirty(newConfirmPassword);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.name,
        state.nickName,
        state.email,
        state.password,
        confirmPassword,
      ]),
    ));
  }
}
