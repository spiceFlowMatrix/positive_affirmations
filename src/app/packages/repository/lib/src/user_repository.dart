import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/src/cache_client.dart';
import 'package:repository/src/exceptions/exceptions.dart';
import 'package:repository/src/exceptions/sign_up_with_email_password_failure.dart';
import 'package:repository/src/models/models.dart';

class UserRepository {
  UserRepository({
    CacheClient? cache,
    FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final CacheClient _cache;
  final FirebaseAuth _firebaseAuth;
  final _usersCollection =
      FirebaseFirestore.instance.collection('users').withConverter(
            fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
            toFirestore: (affirmation, _) => affirmation.fieldValues,
          );

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
    // if (_firebaseAuth.currentUser == null) return Stream.value(AppUser.empty);
    //
    // return _usersCollection
    //     .doc(_firebaseAuth.currentUser!.uid)
    //     .snapshots()
    //     .map((event) => event.data() == null ? AppUser.empty : event.data()!);
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  Future<AppUser> signUpWithEmailPassword({
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
      });

      await userCredential.user?.updateDisplayName(name);

      AppUser newUser = AppUser(
        id: userCredential.user?.uid ?? AppUser.empty.id,
        name: userCredential.user?.displayName ?? AppUser.empty.name,
        email: userCredential.user?.email ?? AppUser.empty.email,
        nickName: nickName != null ? nickName.trim() : '',
        emailVerified: userCredential.user?.emailVerified ?? false,
        accountCreated: true,
      );
      await _usersCollection
          .doc(newUser.id)
          .set(newUser)
          .then((value) =>
              debugPrint('User added successfully: ${newUser.toString()}'))
          .catchError((error) => debugPrintStack());

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      debugPrint(_.toString());
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> resendVerificationCode() async {
    final User? currentFirebaseUser = _firebaseAuth.currentUser;

    if (currentFirebaseUser != null && !currentFirebaseUser.emailVerified) {
      final actionCodeSettings = ActionCodeSettings(
        url:
            'https://affirmations.hrahimy.com/?email=${currentFirebaseUser.email}',
        dynamicLinkDomain: 'affirmations.hrahimy.com',
        androidPackageName: 'com.positiveaffirmations.mobile_app',
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.positiveaffirmations.mobile_app',
        handleCodeInApp: true,
      );
      await currentFirebaseUser.sendEmailVerification(actionCodeSettings);
    }
  }

  Future<void> editUser({
    String? name,
    String? nickName,
  }) async {
    final User? currentFirebaseUser = _firebaseAuth.currentUser;

    if (currentFirebaseUser == null) return;

    if (name != null) {
      await currentFirebaseUser.updateDisplayName(name);
    }

    await _usersCollection.doc(currentUser.id).set(currentUser.copyWith(
          name: name ?? currentUser.name,
          nickName: nickName ?? currentUser.nickName,
        ));
  }

  Future<AppUser> updateProfilePicture(String base64Picture) async {
    String dataUrl = 'data:image/jpeg;base64,$base64Picture';
    try {
      final url = await FirebaseStorage.instance
          .ref('users/${currentUser.id}/picture.jpg')
          .putString(dataUrl, format: PutStringFormat.dataUrl)
          .then((p0) => p0.ref.getDownloadURL());
      await _firebaseAuth.currentUser!.updatePhotoURL(url);
      return _firebaseAuth.currentUser!.toUser;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      rethrow;
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
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
      emailVerified: emailVerified,
    );
  }
}
