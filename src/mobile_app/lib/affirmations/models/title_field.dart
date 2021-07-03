import 'package:formz/formz.dart';

enum TitleFieldValidationError { empty, invalid }

class TitleField extends FormzInput<String, TitleFieldValidationError> {
  const TitleField.pure() : super.pure('');

  const TitleField.dirty([String value = '']) : super.dirty(value);

  @override
  TitleFieldValidationError? validator(String value) {
    if (value.isEmpty) return TitleFieldValidationError.empty;
    if (value.contains(new RegExp(r'[^\s\w]')))
      return TitleFieldValidationError.invalid;
  }
}
