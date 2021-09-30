import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';

class ReaffirmationFormScreenArguments extends Equatable {
  const ReaffirmationFormScreenArguments({required this.reaffirmationBloc});

  final ReaffirmationBloc reaffirmationBloc;

  @override
  List<Object?> get props => [reaffirmationBloc];
}

class ReaffirmationFormScreen extends StatelessWidget {
  static const String routeName = '/reaffirmationFormScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as ReaffirmationFormScreenArguments;
    return BlocProvider<ReaffirmationBloc>.value(
      value: args.reaffirmationBloc,
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
          child: Text('Reaffirmation Form Screen'),
        ),
      ),
    );
  }
}
