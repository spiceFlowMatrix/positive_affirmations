import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

enum EmailFieldValidationError { invalid }

class EmailField extends FormzInput<String, EmailFieldValidationError> {
  const EmailField.pure() : super.pure('');

  const EmailField.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailFieldValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailFieldValidationError.invalid;
  }

  String? buildErrorText(BuildContext context) {
    if (error != null && !pure && value.isNotEmpty) {
      switch (error) {
        case EmailFieldValidationError.invalid:
          return 'Invalid email.';
        default:
          return null;
      }
    }
    return null;
  }
}
