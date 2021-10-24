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

  Stream<List<Affirmation>> getAffirmations({
    int? skip,
    int? take,
    String? searchQuery,
  }) {
    return affirmationsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        return Affirmation.fromSnapshot(e);
      }).toList();
    });
  }
}
