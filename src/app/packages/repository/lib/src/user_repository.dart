import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/src/models/models.dart';

class UserRepository {
  Future<AppUser> createUser({
    required String name,
    required String email,
    required String password,
    String? nickName,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      AppUser newUser = AppUser(
        id: userCredential.user?.uid ?? AppUser.empty.id,
        name: userCredential.user?.displayName ?? AppUser.empty.name,
        email: userCredential.user?.email ?? AppUser.empty.email,
        nickName: nickName != null ? nickName.trim() : '',
        emailVerified: userCredential.user?.emailVerified ?? false,
        accountCreated: true,
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .add(newUser.fieldValues)
          .then((value) => {})
          .catchError((error) => {});

      return newUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      rethrow;
    } catch (_) {
      debugPrint(_.toString());
      rethrow;
    }
  }
}
