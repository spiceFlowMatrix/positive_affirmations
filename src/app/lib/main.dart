import 'package:app/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (!kReleaseMode) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }
  final documentsDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: documentsDirectory);

  runApp(App(
    userRepository: UserRepository(),
    affirmationsRepository: AffirmationsRepository(),
  ));
}
