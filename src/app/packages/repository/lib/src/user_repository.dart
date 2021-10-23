import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/src/cache_client.dart';
import 'package:repository/src/models/models.dart';

class UserRepository {
  UserRepository({
    CacheClient? cache,
    FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final CacheClient _cache;
  final FirebaseAuth _firebaseAuth;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  AppUser get currentUser {
    return _cache.read<AppUser>(key: userCacheKey) ?? AppUser.empty;
  }

  /// Stream of [AppUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AppUser.empty] if the user is not authenticated.
  Stream<AppUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  Future<AppUser> createUser({
    required String name,
    required String email,
    required String password,
    String? nickName,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) {
        debugPrint(
            'Successfully created user with email/password: ${value.toString()}');
        return value;
      }).catchError((error) {
        debugPrint(error.toString());
      });

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
          .then((value) =>
              debugPrint('User added successfully: ${newUser.toString()}'))
          .catchError((error) => debugPrintStack());

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

extension on User {
  AppUser get toUser {
    return AppUser(
      id: uid,
      email: email ?? '',
      name: displayName ?? '',
      pictureB64Enc: photoURL ?? '',
    );
  }
}
