import 'package:app/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnverifiedAccountScreen extends StatelessWidget {
  const UnverifiedAccountScreen({Key? key}) : super(key: key);
  static const String routeName = '/unverifiedAccountScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const [
            FaIcon(PositiveAffirmationsConsts.verifyAccountMessageIcon),
          ],
        ),
      ),
    );
  }
}
