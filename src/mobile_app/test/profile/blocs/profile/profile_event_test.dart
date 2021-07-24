import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';

void main() {
  const mockUser = PositiveAffirmationsConsts.seedUser;
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
