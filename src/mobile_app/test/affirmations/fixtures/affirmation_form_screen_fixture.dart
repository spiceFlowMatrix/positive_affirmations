import 'package:flutter/material.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:mobile_app/models/affirmation.dart';

class AffirmationFormScreenFixture extends StatelessWidget {
  AffirmationFormScreenFixture({
    required this.affirmationsBloc,
    required this.affirmationFormBloc,
    this.toUpdateAffirmation,
  });

  final AffirmationsBloc affirmationsBloc;
  final AffirmationFormBloc affirmationFormBloc;
  final Affirmation? toUpdateAffirmation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = AffirmationFormScreenArguments(
          affirmationsBloc: affirmationsBloc,
          affirmationFormBloc: affirmationFormBloc,
          toUpdateAffirmation: toUpdateAffirmation,
        );

        return MaterialPageRoute(
          builder: (context) {
            return AffirmationFormScreen();
          },
          settings: RouteSettings(
            name: AffirmationFormScreen.routeName,
            arguments: args,
          ),
        );
      },
      initialRoute: AffirmationFormScreen.routeName,
      // routes: PositiveAffirmationsRoutes().routes(context),
    );
  }
}
