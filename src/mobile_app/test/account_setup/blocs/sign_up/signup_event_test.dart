import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';

void main() {
  const name = 'mockName';
  const nickName = 'mockNickName';
  group('[SignUpEvent]', () {
    group('[NameUpdated]', () {
      test('supports value comparisons', () {
        expect(NameUpdated(name), NameUpdated(name));
      });
    });
    group('[NameSubmitted]', () {
      test('supports value comparisons', () {
        expect(NameSubmitted(), NameSubmitted());
      });
    });
    group('[NickNameUpdated]', () {
      test('supports value comparisons', () {
        expect(NickNameUpdated(nickName), NickNameUpdated(nickName));
      });
    });
    group('[NameSubmitted]', () {
      test('supports value comparisons', () {
        expect(NickNameSubmitted(), NickNameSubmitted());
      });
    });
  });
}
