import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository/repository.dart';

class AffirmationsRepository {
  final affirmationsCollection = FirebaseFirestore.instance
      .collection('affirmations')
      .withConverter(
        fromFirestore: (snapshot, _) => Affirmation.fromJson(snapshot.data()!),
        toFirestore: (affirmation, _) => affirmation.fieldValues,
      );

  Future<void> saveAffirmation(Affirmation affirmation) async {
    await affirmationsCollection.add(affirmation);
  }

  Future<List<Affirmation>> getAffirmations({
    int? skip,
    int? take,
    String? searchQuery,
  }) async {
    return await affirmationsCollection
        .orderBy(Affirmation.fieldCreatedOn)
        .startAt([skip ?? 0])
        .limit(take ?? 10)
        .get()
        .then((value) {
          return value.docs.map((snapshot) {
            return Affirmation.fromSnapshot(snapshot);
          }).toList();
        });
  }
}
