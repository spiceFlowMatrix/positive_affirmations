import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: documentsDirectory);
  }

  runApp(App(
    userRepository: UserRepository(),
  ));
}
