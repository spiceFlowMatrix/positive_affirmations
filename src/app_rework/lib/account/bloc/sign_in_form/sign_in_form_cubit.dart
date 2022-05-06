import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';

part 'sign_in_form_state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit() : super(const SignInFormState());
}
