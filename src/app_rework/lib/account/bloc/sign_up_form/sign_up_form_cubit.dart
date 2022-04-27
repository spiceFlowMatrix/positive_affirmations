import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:repository/repository.dart';

part 'sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit({
    required ApiClient apiClient,
    required AuthenticationRepository authRepo,
  })  : _apiClient = apiClient,
        _authRepo = authRepo,
        super(const SignUpFormState());

  final ApiClient _apiClient;
  final AuthenticationRepository _authRepo;

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

  Future<void> submit() async {
    if (!state.status.isValidated) return;
    if (state.status.isSubmissionInProgress) return;

    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    try {
      final command = SignUpCommandDto(
        displayName: state.name.value,
        nickName: state.nickName.value,
        email: state.email.value,
        password: state.confirmPassword.value,
      );
      final apiResponse = await _apiClient.UsersApiController_signUpUser(
        body: command,
      );

      if (apiResponse.isSuccessful) {
        await _authRepo.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.confirmPassword.value,
        );

        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          error: '',
        ));
      } else {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          error: apiResponse.error.toString(),
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: _.toString(),
      ));
    }
  }
}
