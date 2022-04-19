import 'package:formz/formz.dart';

enum EmailFieldValidationError { empty, invalid }

class EmailField extends FormzInput<String, EmailFieldValidationError> {
  const EmailField.pure() : super.pure('');

  const EmailField.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailFieldValidationError? validator(String? value) {
    if (value != null && value.isEmpty) return EmailFieldValidationError.empty;
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailFieldValidationError.invalid;
  }
}
