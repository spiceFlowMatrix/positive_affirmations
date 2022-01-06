import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser != null
              ? AuthState.authenticated(authenticationRepository.currentUser!)
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        if (user != null) {
          add(AppUserChanged(user));
        }
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User?> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AuthState> emit) {
    emit(event.user != null
        ? AuthState.authenticated(event.user!)
        : const AuthState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
