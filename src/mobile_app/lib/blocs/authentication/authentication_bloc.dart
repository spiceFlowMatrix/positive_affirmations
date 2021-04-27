import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/models.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield _mapAuthenticationStatusChangedToState(event, state);
    } else if (event is AuthenticationLogoutRequested) {
      yield AuthenticationState.unauthenticated();
    }
  }

  AuthenticationState _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event, AuthenticationState state) {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated(event.user!);
      default:
        return AuthenticationState.unknown();
    }
  }
}
