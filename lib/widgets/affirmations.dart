import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:positive_affirmations/positive_affirmation_keys.dart';

class Affirmations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffirmationsBloc, AffirmationsState>(
      builder: (context, state) {
        if (state is AffirmationsLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AffirmationsLoadSuccess) {
          final affirmations = state.affirmations;
          return ListView.builder(
            key: PositiveAffirmationsKeys.affirmationsList,
            itemCount: affirmations.length,
            itemBuilder: (BuildContext context, int index) {
              final affirmation = affirmations[index];
              return ListTile(
                title: Text(affirmation.title != null ? affirmation.title : ''),
              );
            },
          );
        } else {
          return Center(
            child: Icon(Icons.error),
          );
        }
      },
    );
  }
}
