import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is UserCreated) {
      yield* _mapUserCreatedToSate(event, state);
    } else if (event is ProfileEdited) {
      yield _mapUserUpdatedToState(event, state);
    } else if (event is PictureUpdated) {
      yield _mapPictureUpdatedToState(event, state);
    }
  }

  Stream<ProfileState> _mapUserCreatedToSate(
      UserCreated event, ProfileState state) async* {
    debugPrint(state.toString());
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .add(event.user.fieldValues)
          .then((value) => debugPrint('user added'))
          .catchError((error) => debugPrint("Failed to add user: $error"));

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: event.user.email.trim(),
        password: event.password,
      )
          .then((value) {
        debugPrint(value.toString());
        return value;
      });
      yield state.copyWith(
        user: event.user.copyWith(
          id: userCredential.user?.uid ?? AppUser.empty.id,
          name: userCredential.user?.displayName ?? AppUser.empty.name,
          email: userCredential.user?.email ?? AppUser.empty.email,
          nickName: event.user.nickName.trim(),
          emailVerified: userCredential.user?.emailVerified ?? false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ProfileState _mapUserUpdatedToState(ProfileEdited event, ProfileState state) {
    final updatedUser = state.user.copyWith(
      name: event.name.trim(),
      nickName: event.nickName.trim(),
    );

    return state.copyWith(user: updatedUser);
  }

  ProfileState _mapPictureUpdatedToState(
      PictureUpdated event, ProfileState state) {
    final updatedUser = state.user.copyWith(
      pictureB64Enc: event.pictureB64Enc,
    );

    return state.copyWith(user: updatedUser);
  }
}

class HydratedProfileBloc extends ProfileBloc with HydratedMixin {
  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    final AppUser? user = AppUser.fromJson(json[ProfileState.fieldUser]);
    return ProfileState(user: user!);
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) => {
        ProfileState.fieldUser: state.user.fieldValues,
      };
}
