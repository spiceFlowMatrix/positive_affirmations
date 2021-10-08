import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/profile/blocs/profile_tab/profile_tab_bloc.dart';

class FakeProfileTabEvent extends Fake implements ProfileTabEvent {}

class MockProfileTabBloc extends MockBloc<ProfileTabEvent, ProfileTab>
    implements ProfileTabBloc {}
