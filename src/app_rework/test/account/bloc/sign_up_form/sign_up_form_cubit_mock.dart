import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';

class FakeSignUpFormState extends Fake implements SignUpFormState {}

class MockSignUpFormCubit extends MockCubit<SignUpFormState>
    implements SignUpFormCubit {}
