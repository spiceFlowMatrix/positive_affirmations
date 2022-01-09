import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account_setup/models/models.dart';
import 'package:repository/repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required ApiClient apiClient,
    required AuthenticationRepository authenticationRepository,
  })  : _apiClient = apiClient,
        _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final ApiClient _apiClient;
  final AuthenticationRepository _authenticationRepository;

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
    if (!state.nameStatus.isSubmissionSuccess) return;

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

  Future<void> submitUser() async {
    emit(state.copyWith(
      submissionStatus: FormzStatus.submissionInProgress,
    ));

    try {
      await _apiClient.UsersApiController_signUpUser(
        body: SignUpCommandDto(
          email: state.email.value,
          password: state.confirmPassword.value,
          displayName: state.name.value,
          nickName: state.nickName.value,
        ),
      ).then((result) {
        return AppUser(
          dbId: result.body!.dbId!.toInt(),
          dbUiId: result.body!.dbUiId!,
          uid: result.body!.uid!,
          emailVerified: result.body!.emailVerified!,
          email: result.body!.email!,
          nickName: result.body!.nickName!,
          displayName: result.body!.displayName!,

        );
      });
      await _authenticationRepository.firstLogInWithEmailAndPassword(
        email: state.email.value,
        password: state.confirmPassword.value,
      );
      emit(state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        submissionError: '',
      ));
    } catch (_) {
      emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
        submissionError: _.toString(),
      ));
    }
  }
}
