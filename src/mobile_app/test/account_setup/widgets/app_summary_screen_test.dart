import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/app_summary_screen_fixture.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockNameField extends Mock implements NameField {}

void main() {
  group('[AppSummaryScreen]', () {
    late SignUpBloc signUpBloc;

    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
    });

    setUp(() {
      signUpBloc = MockSignUpBloc();
    });

    testWidgets('all components exist', (tester) async {
      await tester.pumpWidget(AppSummaryScreenFixture(signUpBloc));

      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryScreen),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryHeader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummarySubheader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryUserNameHeader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryAnimatedBody),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.skipAppSummaryButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.changeNickNameButton),
        findsOneWidget,
      );
    });
  });
}
