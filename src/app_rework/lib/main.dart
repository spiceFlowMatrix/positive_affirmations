import 'package:api_client/api_client.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/app.dart';
import 'package:positive_affirmations/bloc_observer.dart';
import 'package:repository/repository.dart';

Future<void> main() async {
  BlocOverrides.runZoned(
    () {},
    blocObserver: AppBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kReleaseMode) {
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final apiClient = ApiClient.create(
    ChopperClient(
      baseUrl: 'http://10.0.2.2:3333',
      converter: $JsonSerializableConverter(),
      interceptors: [
        (Request request) async {
          if (FirebaseAuth.instance.currentUser != null) {
            final token = await FirebaseAuth.instance.currentUser!.getIdToken();
            final updatedHeaders = Map<String, String>.from(request.headers);
            if (updatedHeaders.containsKey('Authorization')) {
              updatedHeaders.update(
                  'Authorization', (value) => 'Bearer $token');
            } else {
              updatedHeaders.addAll({'Authorization': 'Bearer $token'});
            }
            return request.copyWith(headers: updatedHeaders);
          } else {
            return request;
          }
        },
      ],
    ),
  );
  runApp(const MyApp());
}
