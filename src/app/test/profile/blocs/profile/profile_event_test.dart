import 'package:flutter_test/flutter_test.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  const mockUser = PositiveAffirmationsRepositoryConsts.seedUser;
  group('[ProfileEvent]', () {
    group('supports value comparisons', () {
      test('[UserCreated]', () {
        expect(
          UserCreated(user: mockUser),
          UserCreated(user: mockUser),
        );
      });
      test('[ProfileEdited]', () {
        expect(
          ProfileEdited(name: mockUser.name, nickName: mockUser.nickName),
          ProfileEdited(name: mockUser.name, nickName: mockUser.nickName),
        );
      });
      test('[PictureUpdated]', () {
        expect(
          PictureUpdated(pictureB64Enc: '32r23rewr32r'),
          PictureUpdated(pictureB64Enc: '32r23rewr32r'),
        );
      });
    });
  });
}
