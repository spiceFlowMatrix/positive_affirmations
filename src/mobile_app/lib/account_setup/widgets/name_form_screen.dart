import 'package:flutter/material.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';

class NameFormScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NameFormScreen());
  }

  Widget _buildLabel() => RichText(
        key: PositiveAffirmationsKeys.nameFieldLabel,
        text: TextSpan(
          style: PositiveAffirmationsTheme.theme.textTheme.headline1?.copyWith(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
                text: 'Hi. My name\'s Buddy\n',
                style: TextStyle(color: Colors.grey)),
            const TextSpan(text: 'What\'s your name?'),
          ],
        ),
      );

  Widget _buildNameField() => const TextField(
        key: PositiveAffirmationsKeys.nameField,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      );

  Widget _buildSubmitButton() => ElevatedButton(
        key: PositiveAffirmationsKeys.nameSubmitButton,
        onPressed: () {},
        child: Text('NEXT'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PositiveAffirmationsKeys.nameFormScreen,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildLabel(),
                const Padding(padding: EdgeInsets.only(top: 10)),
                _buildNameField(),
                const Padding(padding: EdgeInsets.only(top: 10)),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
