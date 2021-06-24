import 'package:formz/formz.dart';

enum NickNameFieldValidationError { invalid }

class NickNameField extends FormzInput<String, NickNameFieldValidationError> {
  const NickNameField.pure() : super.pure('');

  const NickNameField.dirty([String value = '']) : super.dirty(value);

  @override
  NickNameFieldValidationError? validator(String value) {
    if (value.contains(new RegExp(r'[^\s\w]')))
      return NickNameFieldValidationError.invalid;
  }
}
