import 'package:flutter/material.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:mobile_app/models/affirmation.dart';

class AffirmationDetailScreenFixture extends StatelessWidget {
  AffirmationDetailScreenFixture({
    required this.affirmation,
    required this.affirmationsBloc,
    this.navigatorObserver,
  });

  final Affirmation affirmation;
  final AffirmationsBloc affirmationsBloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = AffirmationDetailScreenArguments(
          affirmation,
          affirmationsBloc,
        );

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
      navigatorObservers: [if (navigatorObserver != null) navigatorObserver!],
    );
  }
}
