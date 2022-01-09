import 'package:formz/formz.dart';

enum NameFieldValidationError { empty, invalid }

class NameField extends FormzInput<String, NameFieldValidationError> {
  const NameField.pure() : super.pure('');

  const NameField.dirty([String value = '']) : super.dirty(value);

  @override
  NameFieldValidationError? validator(String value) {
    if (value.isEmpty) return NameFieldValidationError.empty;
    if (value.contains(RegExp(r'[^\s\w]'))) {
      return NameFieldValidationError.invalid;
    }
  }
}
