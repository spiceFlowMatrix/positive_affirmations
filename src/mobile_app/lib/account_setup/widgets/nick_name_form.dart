import 'package:flutter/material.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class NickNameForm extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              RichText(
                key: PositiveAffirmationsKeys.nickNameFieldLabel,
                text: TextSpan(text: 'label'),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              TextField(
                key: PositiveAffirmationsKeys.nickNameField,
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              ElevatedButton(
                key: PositiveAffirmationsKeys.nickNameSubmitButton,
                onPressed: () {},
                child: Text('NEXT'),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              OutlinedButton(
                key: PositiveAffirmationsKeys.changeNameButton,
                onPressed: () {},
                child: Text('BACK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
