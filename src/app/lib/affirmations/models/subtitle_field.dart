import 'package:formz/formz.dart';

enum SubtitleFieldValidationError { invalid }

class SubtitleField extends FormzInput<String, SubtitleFieldValidationError> {
  const SubtitleField.pure() : super.pure('');

  const SubtitleField.dirty([String value = '']) : super.dirty(value);

  @override
  SubtitleFieldValidationError? validator(String value) {
    if (value.contains(new RegExp(r'[^\s\w]')))
      return SubtitleFieldValidationError.invalid;
  }
}
