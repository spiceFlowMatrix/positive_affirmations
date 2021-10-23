import 'package:repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  Future<AppUser> createUser(String name, String? nickName) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => AppUser(
        id: Uuid().v4(),
        name: name,
        nickName: nickName ?? '',
      ),
    );
  }
}
