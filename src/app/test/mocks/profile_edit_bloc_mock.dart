import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/profile/blocs/profile_edit/profile_edit_bloc.dart';

class FakeProfileEditEvent extends Fake implements ProfileEditEvent {}

class FakeProfileEditState extends Fake implements ProfileEditState {}

class MockProfileEditBloc extends MockBloc<ProfileEditEvent, ProfileEditState>
    implements ProfileEditBloc {}
