import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';

class FakeApptabEvent extends Fake implements ApptabEvent {}

class MockApptabBloc extends MockBloc<ApptabEvent, AppTab>
    implements ApptabBloc {}
