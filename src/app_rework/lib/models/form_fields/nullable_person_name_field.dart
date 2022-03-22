import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

enum NullablePersonNameFieldValidationError { invalid }

class NullablePersonNameField
    extends FormzInput<String?, NullablePersonNameFieldValidationError> {
  const NullablePersonNameField.pure() : super.pure(null);

  const NullablePersonNameField.dirty([String? value]) : super.dirty(value);

  @override
  NullablePersonNameFieldValidationError? validator(String? value) {
    if (value != null && value.contains(RegExp(r'[^\s\w]'))) {
      return NullablePersonNameFieldValidationError.invalid;
    }
    return null;
  }

  String? buildErrorText(BuildContext context) {
    if (error != null && !pure && value != null) {
      if (value!.isNotEmpty) {
        switch (error) {
          case NullablePersonNameFieldValidationError.invalid:
            return 'Name cannot contain any of the following characters: * . ( ) / \\ [ ] { } \$ = - & ^ % # @ ! ~ \' "';
          default:
            return null;
        }
      }
    }
    return null;
  }
}
