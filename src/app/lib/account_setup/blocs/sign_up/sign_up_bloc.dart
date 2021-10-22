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
    } else if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is AccountDetailsSubmitted) {
      yield _mapAccountDetailsSubmittedToState(event, state);
    } else if (event is UserSubmitted) {
      yield* _mapUserSubmittedToState(event, state);
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
    if (!state.nameStatus.isValidated) return state;

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
    if (!state.nickNameStatus.isValidated) return state;

    return state.copyWith(
      nickName: NickNameField.dirty(state.nickName.value.trim()),
      nickNameStatus: FormzStatus.submissionSuccess,
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

  SignUpState _mapAccountDetailsSubmittedToState(
      AccountDetailsSubmitted event, SignUpState state) {
    if (!state.nickNameStatus.isValidated) return state;

    return state.copyWith(
      email: EmailField.dirty(state.nickName.value.trim()),
      emailStatus: FormzStatus.submissionSuccess,
    );
  }

  Stream<SignUpState> _mapUserSubmittedToState(
      UserSubmitted event, SignUpState state) async* {
    yield state.copyWith(submissionStatus: FormzStatus.submissionInProgress);

    try {
      final User newUser = await userRepository.createUser(
          state.name.value, state.nickName.value);

      yield state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        createdUser: newUser,
      );
    } catch (_) {
      yield state.copyWith(submissionStatus: FormzStatus.submissionFailure);
    }
  }
}
