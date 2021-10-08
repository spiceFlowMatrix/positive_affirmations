import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';

class FakeAffirmationsEvent extends Fake implements AffirmationsEvent {}

class FakeAffirmationsState extends Fake implements AffirmationsState {}

class MockAffirmationsBloc
    extends MockBloc<AffirmationsEvent, AffirmationsState>
    implements AffirmationsBloc {}
