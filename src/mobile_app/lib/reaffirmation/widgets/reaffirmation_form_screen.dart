import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:repository/repository.dart';

class ReaffirmationFormScreenArguments extends Equatable {
  const ReaffirmationFormScreenArguments({
    this.reaffirmationBloc,
    required this.affirmationsBloc,
    required this.forAffirmation,
  });

  final ReaffirmationBloc? reaffirmationBloc;
  final AffirmationsBloc affirmationsBloc;
  final Affirmation forAffirmation;

  @override
  List<Object?> get props =>
      [reaffirmationBloc, affirmationsBloc, forAffirmation];
}

class ReaffirmationFormScreen extends StatelessWidget {
  static const String routeName = '/reaffirmationFormScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as ReaffirmationFormScreenArguments;
    final reaffirmationBloc = args.reaffirmationBloc ?? new ReaffirmationBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReaffirmationBloc>.value(value: reaffirmationBloc),
        BlocProvider<AffirmationsBloc>.value(value: args.affirmationsBloc),
      ],
      child: Scaffold(
        key: PositiveAffirmationsKeys.reaffirmationFormScreen,
        appBar: AppBar(
          title: Text(
            'Reaffirmation',
            key: PositiveAffirmationsKeys.reaffirmationFormScreenTitle,
          ),
          leading: IconButton(
            key: PositiveAffirmationsKeys.reaffirmationFormScreenBackButton,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
          ),
        ),
        body: Center(
          child: Text(
              'Reaffirmation Form Screen for ${args.forAffirmation.title}'),
        ),
      ),
    );
  }
}
