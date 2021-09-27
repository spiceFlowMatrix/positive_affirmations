import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:repository/repository.dart';

void main() {
  final User mockUser = PositiveAffirmationsRepositoryConsts.seedUser;
  group('[ProfileEditEvent]', () {
    group('supports value comparisons', () {
      test('[NameUpdated]', () {
        expect(NameUpdated(mockUser.name), NameUpdated(mockUser.name));
      });
      test('[NickNameUpdated]', () {
        expect(
          NickNameUpdated(mockUser.nickName),
          NickNameUpdated(mockUser.nickName),
        );
      });
      test('[ProfileEditSubmitted]', () {
        expect(ProfileEditSubmitted(), ProfileEditSubmitted());
      });
    });
  });
}
