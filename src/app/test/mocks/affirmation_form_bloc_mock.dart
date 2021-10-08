import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';

class FakeAffirmationFormEvent extends Fake implements AffirmationFormEvent {}

class FakeAffirmationFormState extends Fake implements AffirmationFormState {}

class MockAffirmationFormBloc
    extends MockBloc<AffirmationFormEvent, AffirmationFormState>
    implements AffirmationFormBloc {}
