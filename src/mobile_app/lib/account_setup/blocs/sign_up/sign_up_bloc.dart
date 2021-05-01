import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/models/models.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState());

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

    return state.copyWith(nameStatus: FormzStatus.submissionSuccess);
  }

  SignUpState _mapNickNameUpdatedToState(
      NickNameUpdated event, SignUpState state) {
    final nickName = NickNameField.dirty(event.nickName);

    return state.copyWith(
      nickName: nickName,
      nickNameStatus: Formz.validate([nickName]),
    );
  }

  SignUpState _mapNickNameSubmittedToState(
      NickNameSubmitted event, SignUpState state) {
    if (!state.nickNameStatus.isValidated) return state;

    return state.copyWith(nickNameStatus: FormzStatus.submissionSuccess);
  }
}
