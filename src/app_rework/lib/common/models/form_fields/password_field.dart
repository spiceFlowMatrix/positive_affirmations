import 'package:formz/formz.dart';

enum PasswordFieldValidationError { empty, invalid }

class PasswordField extends FormzInput<String, PasswordFieldValidationError> {
  const PasswordField.pure() : super.pure('');

  const PasswordField.dirty([String value = '']) : super.dirty(value);

  static final _passwordFieldRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordFieldValidationError? validator(String? value) {
    if (value != null && value.isEmpty) {
      return PasswordFieldValidationError.empty;
    }
    return _passwordFieldRegExp.hasMatch(value ?? '')
        ? null
        : PasswordFieldValidationError.invalid;
  }
}
