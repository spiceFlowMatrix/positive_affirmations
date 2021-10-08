import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';

class FakeProfileState extends Fake implements ProfileState {}

class FakeProfileEvent extends Fake implements ProfileEvent {}

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}
