import 'package:affirmations_repository_local_storage/affirmations_repository_local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:positive_affirmations/blocs/simple_bloc_observer.dart';
import 'package:positive_affirmations/models/affirmation.dart';
import 'package:positive_affirmations/positive_affirmation_keys.dart';
import 'package:positive_affirmations/routes.dart';
import 'package:positive_affirmations/screens/add_edit_screen.dart';
import 'package:positive_affirmations/screens/home_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  const DatabaseClient dbClient = DatabaseClient.instance;
  const LocalStorageRepository localStorageRepository =
      const LocalStorageRepository(localStorage: dbClient);
  runApp(BlocProvider(
    create: (context) {
      return AffirmationsBloc(
        affirmationsRepository: localStorageRepository,
      )..add(AffirmationsLoaded());
    },
    child: PositiveAffirmationsApp(),
  ));
}

class PositiveAffirmationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Positive Affirmations',
      routes: {
        PositiveAffirmationsRoutes.home: (context) {
          return HomeScreen();
        },
        PositiveAffirmationsRoutes.addAffirmation: (context) {
          return AddEditScreen(
            key: PositiveAffirmationsKeys.addAffirmationScreen,
            onSave: (message, remindOn) {
              BlocProvider.of<AffirmationsBloc>(context).add(
                AffirmationAdded(
                  Affirmation(
                    message,
                    // TODO: Implement realistic way of catching remind on time
                    DateTime.now(),
                  ),
                ),
              );
            },
            isEditing: false,
          );
        }
      },
    );
  }
}
