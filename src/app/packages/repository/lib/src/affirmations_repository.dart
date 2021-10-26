import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository/repository.dart';
import 'package:uuid/uuid.dart';

class AffirmationsRepository {
  final affirmationsCollection = FirebaseFirestore.instance
      .collection('affirmations')
      .withConverter(
        fromFirestore: (snapshot, _) => Affirmation.fromJson(snapshot.data()!),
        toFirestore: (affirmation, _) => affirmation.fieldValues,
      );

  CollectionReference<AffirmationLike> likesCollection(String affirmationId) {
    return affirmationsCollection
        .doc(affirmationId)
        .collection('likes')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              AffirmationLike.fromJson(snapshot.data()!),
          toFirestore: (like, _) => like.fieldValues,
        );
  }

  Future<void> saveAffirmation(Affirmation affirmation) async {
    await affirmationsCollection.doc(affirmation.id).set(affirmation);
  }

  Future<List<Affirmation>> getAffirmations({
    int? skip,
    int? take,
    String? searchQuery,
    String? userId,
  }) async {
    var query = affirmationsCollection
        .orderBy(Affirmation.fieldCreatedOn)
        .startAt([skip ?? 0]).limit(take ?? 10);
    if (userId != null) {
      query = query.where(Affirmation.fieldCreatedById, isEqualTo: userId);
    } else {
      query = query.where(Affirmation.fieldActive, isEqualTo: true);
    }
    return await query.get().then((value) {
      return value.docs.map((snapshot) {
        return snapshot.data();
      }).toList();
    });
  }

  Future<Affirmation?> toggleLiked({
    required String affirmationId,
    required String userId,
  }) async {
    // final existingLikes = await likesCollection(affirmationId)
    //     .where(
    //       AffirmationLike.fieldByUserId,
    //       isEqualTo: userId,
    //     )
    //     .get()
    //     .then((value) {
    //   return value.docs.map((e) => e.data()).toList();
    // });

    Affirmation? affirmation = await affirmationsCollection
        .doc(affirmationId)
        .get()
        .then((snap) => snap.data());

    if (affirmation == null) return null;

    // Create new like if none exist by the given user, increment likes count for the given affirmation, return updated affirmation with liked set to true
    // Else delete all likes by the given user, decrement likes count for given affirmation, return updated affirmation with liked set to false
    if (affirmation.likes.isEmpty ||
        !affirmation.likes.any((element) => element.byUserId == userId)) {
      final newLike = AffirmationLike(
        id: const Uuid().v4(),
        byUserId: userId,
      );
      affirmation = affirmation.copyWith(
        likeCount: affirmation.likeCount + 1,
        likes: [...affirmation.likes, newLike],
        liked: true,
      );
    } else {
      List<AffirmationLike> likes = [...affirmation.likes];
      likes.removeWhere((element) => element.byUserId == userId);
      affirmation = affirmation.copyWith(
        likeCount: affirmation.likeCount - 1,
        liked: false,
        likes: [...likes],
      );
    }

    await affirmationsCollection.doc(affirmationId).set(affirmation);

    return affirmation;
  }

  Future<Affirmation> createReaffirmation({
    required String affirmationId,
    required Reaffirmation reaffirmation,
  }) async {
    affirmationsCollection
        .doc(affirmationId)
        .collection('reaffirmations')
        .doc(reaffirmation.id)
        .set(reaffirmation.fieldValues);

    return affirmationsCollection.doc(affirmationId).get().then((value) async {
      final fetchedAffirmation = Affirmation.fromSnapshot(value).copyWith(
        totalReaffirmations:
            Affirmation.fromSnapshot(value).totalReaffirmations + 1,
      );
      await affirmationsCollection.doc(affirmationId).update(
            fetchedAffirmation.fieldValues,
          );
      return fetchedAffirmation;
    });
  }

  Future<Affirmation?> editAffirmation(
    String affirmationId, {
    String? title,
    String? subtitle,
  }) async {
    Affirmation? toUpdateAffirmation = await affirmationsCollection
        .doc(affirmationId)
        .get()
        .then((snap) => snap.data());

    if (toUpdateAffirmation == null) return null;

    toUpdateAffirmation = toUpdateAffirmation.copyWith(
      title: title ?? toUpdateAffirmation.title,
      subtitle: subtitle ?? toUpdateAffirmation.subtitle,
    );

    await affirmationsCollection.doc(affirmationId).set(toUpdateAffirmation);

    return toUpdateAffirmation;
  }

  Future<Affirmation> toggleActivated(String affirmationId) async {
    Affirmation toUpdate = await affirmationsCollection
        .doc(affirmationId)
        .get()
        .then((snap) => Affirmation.fromSnapshot(snap));

    toUpdate = toUpdate.copyWith(active: !toUpdate.active);

    await affirmationsCollection.doc(affirmationId).set(toUpdate);

    return toUpdate;
  }

  Future<void> deleteAffirmation(String affirmationId) async {
    await affirmationsCollection.doc(affirmationId).delete();
  }
}
