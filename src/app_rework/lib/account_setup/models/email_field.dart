import 'package:formz/formz.dart';

enum EmailFieldValidationError { empty, invalid_email }

class EmailField extends FormzInput<String, EmailFieldValidationError> {
  const EmailField.pure() : super.pure('');

  const EmailField.dirty([String value = '']) : super.dirty(value);

  @override
  EmailFieldValidationError? validator(String value) {
    if (value.isEmpty) return EmailFieldValidationError.empty;
    if (!value.contains(RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      return EmailFieldValidationError.invalid_email;
    }
  }
}
