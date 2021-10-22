import 'package:formz/formz.dart';

enum PasswordFieldValidationError { empty, invalid_password }

class PasswordField extends FormzInput<String, PasswordFieldValidationError> {
  const PasswordField.pure() : super.pure('');

  const PasswordField.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordFieldValidationError? validator(String value) {
    if (value.isEmpty) return PasswordFieldValidationError.empty;
    // if (!value.contains(RegExp(
    //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
    //   return PasswordFieldValidationError.invalid_password;
  }
}
