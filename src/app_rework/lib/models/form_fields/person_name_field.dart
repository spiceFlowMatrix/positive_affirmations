import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

enum PersonNameFieldValidationError { empty, invalid }

class PersonNameField
    extends FormzInput<String, PersonNameFieldValidationError> {
  const PersonNameField.pure() : super.pure('');

  const PersonNameField.dirty([String value = '']) : super.dirty(value);

  @override
  PersonNameFieldValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PersonNameFieldValidationError.empty;
    }
    if (value.contains(RegExp(r'[^\s\w]'))) {
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
