import 'package:flutter/material.dart';
import 'package:positive_affirmations/common/models/form_fields/person_name_field.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';

class CommonPersonNameField extends StatefulWidget {
  const CommonPersonNameField({
    Key? key,
    required this.name,
    this.onChanged,
  }) : super(key: key);
  final PersonNameField name;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _CommonPersonNameFieldState();
}

class _CommonPersonNameFieldState extends State<CommonPersonNameField> {
  late FocusNode _focusNode;
  bool _canShowError = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _canShowError = !_focusNode.hasFocus;
    });
  }

  String? get _errorText {
    if (widget.name.error != null &&
        !widget.name.pure &&
        widget.name.value.isNotEmpty &&
        _canShowError) {
      switch (widget.name.error) {
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
        focusNode: _focusNode,
        initialValue: widget.name.value,
        onChanged: widget.onChanged,
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
