import 'package:flutter/material.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/affirmation.dart';

class AffirmationFormScreenArguments {
  AffirmationFormScreenArguments({
    required this.affirmationsBloc,
    this.affirmationFormBloc,
    this.editAffirmation,
  });

  final AffirmationsBloc affirmationsBloc;
  final AffirmationFormBloc? affirmationFormBloc;
  final Affirmation? editAffirmation;
}

class AffirmationFormScreen extends StatelessWidget {
  static const String routeName = '/affirmationFormScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
