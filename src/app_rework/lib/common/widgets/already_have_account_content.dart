import 'package:flutter/material.dart';
import 'package:positive_affirmations/common/common_keys.dart';
import 'package:positive_affirmations/consts.dart';
import 'package:positive_affirmations/theme.dart';

class AlreadyHaveAccountPanel extends StatelessWidget {
  const AlreadyHaveAccountPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Divider(
          height: 30,
          thickness: 1.5,
        ),
        AlreadyHaveAccountLabel(),
        Padding(padding: EdgeInsets.only(top: 10)),
        AlreadyHaveAccountSignInButton(),
      ],
    );
  }
}

class AlreadyHaveAccountLabel extends StatelessWidget {
  const AlreadyHaveAccountLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      PositiveAffirmationsConsts.alreadyHaveAccountLabelText,
      key: CommonWidgetKeys.alreadyHaveAccountLabel,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black.withOpacity(0.82),
      ),
    );
  }
}

class AlreadyHaveAccountSignInButton extends StatelessWidget {
  const AlreadyHaveAccountSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: CommonWidgetKeys.alreadyHaveAccountSignInButton,
      onPressed: null,
      child: const Text(
        PositiveAffirmationsConsts.alreadyHaveAccountSignInButtonText,
      ),
      style: OutlinedButton.styleFrom(
        primary: AppTheme.secondaryColor,
        side: BorderSide(color: AppTheme.secondaryColor),
      ),
    );
  }
}
