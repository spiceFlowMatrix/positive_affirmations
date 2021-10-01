import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';

class FakeReaffirmationEvent extends Fake implements ReaffirmationEvent {}

class FakeReaffirmationState extends Fake implements ReaffirmationState {}

class MockReaffirmationBloc
    extends MockBloc<ReaffirmationEvent, ReaffirmationState>
    implements ReaffirmationBloc {}
