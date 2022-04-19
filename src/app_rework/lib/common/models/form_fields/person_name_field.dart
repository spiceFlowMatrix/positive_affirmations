import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

enum PersonNameFieldValidationError { empty, invalid }

class PersonNameField
    extends FormzInput<String, PersonNameFieldValidationError> {
  const PersonNameField.pure() : super.pure('');

  const PersonNameField.dirty([String value = '']) : super.dirty(value);

  // Used following regex tool to find the regex that worked:
  // https://regex101.com/
  static final _invalidRegexFormat =
      RegExp(r'(?:[-!$%^&*#@()_+|~=''\'`{}[]:";<>?,./\\])|(\\d)');

  @override
  PersonNameFieldValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PersonNameFieldValidationError.empty;
    }
    if (_invalidRegexFormat.hasMatch(value)) {
      return PersonNameFieldValidationError.invalid;
    }
    return null;
  }

  String? buildErrorText(BuildContext context) {
    if (error != null && !pure && value.isNotEmpty) {
      switch (error) {
        case PersonNameFieldValidationError.invalid:
          return 'Name cannot contain any of the following characters: * . ( ) / \\ [ ] { } \$ = - & ^ % # @ ! ~ \' "';
        case PersonNameFieldValidationError.empty:
          return 'Name is required.';
        default:
          return null;
      }
    }
    return null;
  }
}
