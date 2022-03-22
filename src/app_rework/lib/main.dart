import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:positive_affirmations/app.dart';
import 'package:positive_affirmations/bloc_observer.dart';
import 'package:positive_affirmations/firebase_options.dart';
import 'package:repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  BlocOverrides.runZoned(
    () {
      runApp(App(
        authenticationRepository: authenticationRepository,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}
