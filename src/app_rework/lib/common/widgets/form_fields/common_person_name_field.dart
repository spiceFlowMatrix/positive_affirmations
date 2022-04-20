import 'package:flutter/material.dart';
import 'package:positive_affirmations/common/models/form_fields/person_name_field.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';

class CommonPersonNameField extends StatelessWidget {
  const CommonPersonNameField({
    Key? key,
    required this.name,
    this.canShowError = false,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);
  final PersonNameField name;
  final bool canShowError;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  String? get _errorText {
    if (name.error != null &&
        !name.pure &&
        name.value.isNotEmpty &&
        canShowError) {
      switch (name.error) {
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

  @override
  Widget build(BuildContext context) {
    return CommonFormPadding(
      child: TextFormField(
        focusNode: focusNode,
        initialValue: name.value,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          labelText: 'Name *',
          errorText: _errorText,
        ),
      ),
    );
  }
}
