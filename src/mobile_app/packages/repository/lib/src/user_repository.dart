import 'package:repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  Future<User> createUser(String name, String? nickName) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => User(
        id: Uuid().v4(),
        name: name,
        nickName: nickName ?? '',
      ),
    );
  }
}
