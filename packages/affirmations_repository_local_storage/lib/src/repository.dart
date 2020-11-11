import 'package:affirmations_repository_core/affirmations_repository_core.dart';
import 'package:affirmations_repository_local_storage/src/database_client.dart';
import 'package:meta/meta.dart';

/// Checks if you are awesome. Spoiler: you are.
class LocalStorageRepository implements AffirmationsRepository {
  final DatabaseClient localStorage;

  const LocalStorageRepository({@required this.localStorage});

  @override
  Future createAffirmation(AffirmationEntity affirmation) async {
    try {
      await localStorage.insertAffirmation(affirmation);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future deleteAffirmation(String id) async {
    await localStorage.deleteAffirmationWithId(id);
  }

  @override
  Future<AffirmationEntity> loadAffirmation(String id) async {
    var affirmation = await localStorage.fetchAffirmationWithId(id);
    return affirmation;
  }

  @override
  Future<List<AffirmationEntity>> loadAffirmations() async {
    var affirmations = await localStorage.fetchAffirmations();
    return affirmations;
  }

  @override
  Future updateAffirmation(String id, {String message, String remindOn}) async {
    await localStorage.updateAffirmation(AffirmationEntity(
      id: id,
      message: message,
      remindOn: remindOn,
    ));
  }
}
