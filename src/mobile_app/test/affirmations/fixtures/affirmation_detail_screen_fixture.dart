import 'package:flutter/material.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:mobile_app/models/affirmation.dart';

class AffirmationDetailScreenFixture extends StatelessWidget {
  AffirmationDetailScreenFixture({required this.affirmation});

  final Affirmation affirmation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = AffirmationDetailScreenArguments(affirmation);

        return MaterialPageRoute(
          builder: (context) {
            return AffirmationDetailScreen();
          },
          settings: RouteSettings(
            name: AffirmationDetailScreen.routeName,
            arguments: args,
          ),
        );
      },
      initialRoute: AffirmationDetailScreen.routeName,
      // routes: PositiveAffirmationsRoutes().routes(context),
    );
  }
}
