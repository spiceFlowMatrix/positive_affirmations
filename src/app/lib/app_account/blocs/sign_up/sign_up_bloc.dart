import 'dart:async';

import 'package:app/models/email_field.dart';
import 'package:app/models/models.dart';
import 'package:app/models/password_field.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.userRepository}) : super(const SignUpState());

  final UserRepository userRepository;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is NameUpdated) {
      yield _mapNameUpdatedToState(event, state);
    } else if (event is NameSubmitted) {
      yield _mapNameSubmittedToState(event, state);
    } else if (event is NickNameUpdated) {
      yield _mapNickNameUpdatedToState(event, state);
    } else if (event is NickNameSubmitted) {
      yield _mapNickNameSubmittedToState(event, state);
    } else if (event is NickNameBacked) {
      yield _mapNickNameBackedToState(event, state);
    } else if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is PasswordUpdated) {
      yield _mapPasswordUpdatedToState(event, state);
    } else if (event is ConfirmPasswordUpdated) {
      yield _mapConfirmPasswordUpdatedToState(event, state);
    } else if (event is AccountDetailsBacked) {
      yield _mapAccountDetailsBackedToState(event, state);
    } else if (event is AccountDetailsSubmitted) {
      yield* _mapAccountDetailsSubmittedToState(event, state);
    }
  }

  SignUpState _mapNameUpdatedToState(NameUpdated event, SignUpState state) {
    final name = NameField.dirty(event.name);

    return state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    );
  }

  SignUpState _mapNameSubmittedToState(NameSubmitted event, SignUpState state) {
    if (state.name.invalid) return state;

    return state.copyWith(
      name: NameField.dirty(state.name.value.trim()),
      nameStatus: FormzStatus.submissionSuccess,
    );
  }

  SignUpState _mapNickNameUpdatedToState(
      NickNameUpdated event, SignUpState state) {
    if (state.name.pure ||
        state.name.invalid ||
        !state.nameStatus.isSubmissionSuccess) return state;

    final nickName = NickNameField.dirty(event.nickName);

    return state.copyWith(
      nickName: nickName,
      nickNameStatus: Formz.validate([nickName]),
    );
  }

  SignUpState _mapNickNameSubmittedToState(
      NickNameSubmitted event, SignUpState state) {
    if (state.nickName.invalid) return state;

    return state.copyWith(
      nickName: NickNameField.dirty(state.nickName.value.trim()),
      nickNameStatus: FormzStatus.submissionSuccess,
    );
  }

  SignUpState _mapNickNameBackedToState(
      NickNameBacked event, SignUpState state) {
    return state.copyWith(
      nameStatus: FormzStatus.pure,
    );
  }

  SignUpState _mapEmailUpdatedToState(EmailUpdated event, SignUpState state) {
    // if (state.email.pure ||
    //     state.email.invalid ||
    //     !state.emailStatus.isSubmissionSuccess) return state;

    final email = EmailField.dirty(event.email);

    return state.copyWith(
      email: email,
      emailStatus: Formz.validate([email]),
    );
  }

  SignUpState _mapPasswordUpdatedToState(
      PasswordUpdated event, SignUpState state) {
    final password = PasswordField.dirty(event.password);

    return state.copyWith(
      password: password,
      passwordStatus: Formz.validate([password]),
      confirmPasswordStatus: FormzStatus.invalid,
    );
  }

  SignUpState _mapConfirmPasswordUpdatedToState(
      ConfirmPasswordUpdated event, SignUpState state) {
    final confirmPassword = PasswordField.dirty(event.confirmPassword);

    return state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordStatus: state.password.value == confirmPassword.value
          ? FormzStatus.valid
          : FormzStatus.invalid,
    );
  }

  SignUpState _mapAccountDetailsBackedToState(
      AccountDetailsBacked event, SignUpState state) {
    return state.copyWith(
      nickNameStatus: FormzStatus.pure,
    );
  }

  Stream<SignUpState> _mapAccountDetailsSubmittedToState(
      AccountDetailsSubmitted event, SignUpState state) async* {
    yield state.copyWith(submissionStatus: FormzStatus.submissionInProgress);

    try {
      AppUser newUser = await userRepository.createUser(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
        nickName: state.nickName.value,
      );

      yield state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        createdUser: newUser,
      );
    } catch (_) {
      yield state.copyWith(submissionStatus: FormzStatus.submissionFailure);
    }
  }
}
