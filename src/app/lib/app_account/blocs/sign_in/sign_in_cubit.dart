import 'package:app/models/email_field.dart';
import 'package:app/models/password_field.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._userRepository) : super(const SignInState());

  final UserRepository _userRepository;

  void emailUpdated(String email) {
    final updatedEmail = EmailField.dirty(email);
    emit(state.copyWith(
      email: updatedEmail,
      status: Formz.validate([
        updatedEmail,
        state.password,
      ]),
    ));
  }

  void passwordUpdated(String password) {
    final updatedPassword = PasswordField.dirty(password);
    emit(state.copyWith(
      password: updatedPassword,
      status: Formz.validate([
        state.email,
        updatedPassword,
      ]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _userRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        error: '',
      ));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: 'Unrecognized error',
      ));
    }
  }
}
