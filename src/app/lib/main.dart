import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/app.dart';
import 'package:app/notification_service.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: documentsDirectory);

    final affirmationsBloc = HydratedAffirmationsBloc(
        authenticatedUser: HydratedProfileBloc().state.user);
    affirmationsBloc.state.affirmations.forEach((affirmation) {
      debugPrint(affirmation.fieldValues.toString());
    });
    affirmationsBloc.add(AffirmationCreated(
        affirmationsBloc.state.affirmations[0].title,
        affirmationsBloc.state.affirmations[0].subtitle));
    // NotificationService().showLetterNotification(
    //   Letter(
    //     id: 32,
    //     affirmation: Affirmation.empty,
    //     reaffirmations: [],
    //     createdOn: DateTime.now(),
    //   ),
    //   'notificationMessage',
    // );
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  final documentsDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: documentsDirectory);

  final affirmationsBloc = HydratedAffirmationsBloc(
      authenticatedUser: HydratedProfileBloc().state.user);
  affirmationsBloc.state.affirmations.forEach((affirmation) {
    debugPrint(affirmation.fieldValues.toString());
  });

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Timer.periodic(Duration(seconds: 5), (timer) {
    Workmanager()
        .registerOneOffTask("2", "simpleTask"); //Android only (see below)
  });

  runApp(App(
    userRepository: UserRepository(),
  ));
}
