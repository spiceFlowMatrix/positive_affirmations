import 'package:app/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnverifiedAccountScreen extends StatelessWidget {
  const UnverifiedAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Align(
            alignment: Alignment.center,
            child: FaIcon(
              PositiveAffirmationsConsts.verifyAccountMessageIcon,
            ),
          ),
          Text(
            PositiveAffirmationsConsts.verifyAccountMessageTitle,
          ),
          Text(
            PositiveAffirmationsConsts.verifyAccountMessageContent,
          ),
        ],
      ),
    );
  }
}
