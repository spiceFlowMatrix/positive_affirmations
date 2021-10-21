import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../mocks/sign_up_bloc_mock.dart';
import '../../mocks/user_repository_mock.dart';
import '../fixtures/name_screen_fixture.dart';

void main() {
  late SignUpBloc signUpBloc;
  late UserRepository userRepository;

  setUpAll(() {
    registerFallbackValue<SignUpState>(FakeSignUpState());
    registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
  });

  setUp(() {
    signUpBloc = MockSignUpBloc();
    userRepository = MockUserRepository();
  });

  group('[NameScreen]', () {
    testWidgets('widgets are composed', (tester) async {
      tester.pumpWidget(NameScreenFixture(
        signUpBloc: signUpBloc,
        userRepository: userRepository,
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.nameFieldLabel),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nameField),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nameSubmitButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountLabel),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountSignInButton),
        findsOneWidget,
      );
    });
  });
}
