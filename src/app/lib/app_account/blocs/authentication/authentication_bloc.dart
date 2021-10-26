import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthenticationState.unauthenticated()) {
    _appUserSubscription = _userRepository.user.listen((user) {
      if (user != AppUser.empty) {
        add(const AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated));
      } else {
        add(const AuthenticationStatusChanged(
            status: AuthenticationStatus.unknown));
      }
    });
  }

  final UserRepository _userRepository;
  late StreamSubscription<AppUser> _appUserSubscription;

  @override
  Future<void> close() {
    _appUserSubscription.cancel();
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield _mapAuthenticationStatusChangedToState(event, state);
    } else if (event is AuthenticationLogoutRequested) {
      yield const AuthenticationState.unauthenticated();
    }
  }

  AuthenticationState _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event, AuthenticationState state) {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return const AuthenticationState.authenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    final AuthenticationStatus status = AuthenticationStatus
        .values[json[AuthenticationState.fieldStatus] as int];

    switch (status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated();
      default:
        return AuthenticationState.unknown();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) => {
        AuthenticationState.fieldStatus: state.status.index,
      };
}
