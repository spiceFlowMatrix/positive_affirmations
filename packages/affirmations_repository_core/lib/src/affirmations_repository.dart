import 'affirmation_entity.dart';

abstract class AffirmationsRepository {
  Future<List<AffirmationEntity>> loadAffirmations();
  Future<AffirmationEntity> loadAffirmation(String id);
  Future createAffirmation(AffirmationEntity affirmation);
  Future updateAffirmation(String id, {String message, String remindOn});
  Future deleteAffirmation(String id);
}
