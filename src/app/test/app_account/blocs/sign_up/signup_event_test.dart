import 'package:app/app_account/blocs/sign_up/sign_up_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const name = 'mockName';
  const nickName = 'mockNickName';
  group('[SignUpEvent]', () {
    group('[NameUpdated]', () {
      test('supports value comparisons', () {
        expect(const NameUpdated(name), const NameUpdated(name));
      });
    });
    group('[NameSubmitted]', () {
      test('supports value comparisons', () {
        expect(const NameSubmitted(), const NameSubmitted());
      });
    });
    group('[NickNameUpdated]', () {
      test('supports value comparisons', () {
        expect(
            const NickNameUpdated(nickName), const NickNameUpdated(nickName));
      });
    });
    group('[NameSubmitted]', () {
      test('supports value comparisons', () {
        expect(const NickNameSubmitted(), const NickNameSubmitted());
      });
    });
  });
}
