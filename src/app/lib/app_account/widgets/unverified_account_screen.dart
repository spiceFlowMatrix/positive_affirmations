import 'package:app/consts.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnverifiedAccountScreen extends StatelessWidget {
  const UnverifiedAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.center,
              child: FaIcon(
                PositiveAffirmationsConsts.verifyAccountMessageIcon,
              ),
            ),
            const Text(
              PositiveAffirmationsConsts.verifyAccountMessageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              PositiveAffirmationsConsts.verifyAccountMessageContent,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
              onPressed: () {
                context.read<ProfileBloc>().add(const VerificationChecked());
              },
              child: const Text('Check Verification'),
            ),
          ],
        ),
      ),
    );
  }
}
