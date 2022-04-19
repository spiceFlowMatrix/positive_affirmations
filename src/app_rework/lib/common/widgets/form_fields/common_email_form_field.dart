import 'package:flutter/material.dart';
import 'package:positive_affirmations/common/models/form_fields/email_field.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';

class CommonEmailFormField extends StatelessWidget {
  const CommonEmailFormField({
    Key? key,
    required this.email,
    this.canShowError = false,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  final EmailField email;

  /* Allow higher level widget control over when an error, if one currently exists
    can be shown.
  * */
  final bool canShowError;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  String? get _errorText {
    if (email.error != null &&
        !email.pure &&
        email.value.isNotEmpty &&
        canShowError) {
      switch (email.error) {
        case EmailFieldValidationError.invalid:
          return 'Invalid email.';
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
        initialValue: email.value,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          labelText: 'Email *',
          errorText: _errorText,
        ),
      ),
    );
  }
}
