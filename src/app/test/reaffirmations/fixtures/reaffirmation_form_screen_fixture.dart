import 'package:flutter/material.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:app/reaffirmation/widgets/reaffirmation_form_screen.dart';
import 'package:repository/repository.dart';

class ReaffirmationFormScreenFixture extends StatelessWidget {
  ReaffirmationFormScreenFixture({
    required this.reaffirmationBloc,
    required this.affirmationsBloc,
    required this.forAffirmation,
  });

  final ReaffirmationBloc reaffirmationBloc;
  final AffirmationsBloc affirmationsBloc;
  final Affirmation forAffirmation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = ReaffirmationFormScreenArguments(
          affirmationsBloc: affirmationsBloc,
          reaffirmationBloc: reaffirmationBloc,
          forAffirmation: forAffirmation,
        );

        return MaterialPageRoute(
          builder: (context) {
            return ReaffirmationFormScreen();
          },
          settings: RouteSettings(
            name: ReaffirmationFormScreen.routeName,
            arguments: args,
          ),
        );
      },
      initialRoute: ReaffirmationFormScreen.routeName,
    );
  }
}
