import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}
