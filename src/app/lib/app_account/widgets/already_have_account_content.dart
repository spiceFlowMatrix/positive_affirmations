import 'package:app/consts.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/positive_affirmations_theme.dart';
import 'package:flutter/material.dart';

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
      key: PositiveAffirmationsKeys.alreadyHaveAccountLabel,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black.withOpacity(0.82),
      ),
    );
  }
}

class AlreadyHaveAccountSignInButton extends StatelessWidget {
  const AlreadyHaveAccountSignInButton({Key? key}) : super(key: key);
  final _snackBar = const SnackBar(
    content: Text(PositiveAffirmationsConsts.underConstructionSnackbarText),
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: PositiveAffirmationsKeys.alreadyHaveAccountSignInButton,
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      },
      child: const Text(
        PositiveAffirmationsConsts.alreadyHaveAccountSignInButtonText,
      ),
      style: OutlinedButton.styleFrom(
        primary: PositiveAffirmationsTheme.highlightColor,
        side: BorderSide(color: PositiveAffirmationsTheme.highlightColor),
      ),
    );
  }
}
