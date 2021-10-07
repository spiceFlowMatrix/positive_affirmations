import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_app/app.dart';
import 'package:mobile_app/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';

void selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  final documentsDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: documentsDirectory);

  runApp(App(
    userRepository: UserRepository(),
  ));
}
