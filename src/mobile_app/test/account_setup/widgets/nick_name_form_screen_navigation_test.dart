import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mockito/mockito.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockNickNameField extends Mock implements NameField {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  var signUpBloc = MockSignUpBloc();

  final mockObserver = MockNavigatorObserver();

  const mockValidName = 'validName';

  group('Navigation', () {
    testWidgets('pressing back button pops back to name form', (tester) async {
      when(signUpBloc.state).thenReturn(const SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(MaterialApp(
        home: NameFormScreen(),
        navigatorObservers: [mockObserver],
      ));

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        mockValidName,
      );

      await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

      await tester.pumpAndSettle();

      verify(mockObserver.didPush(NickNameFormScreen.route(signUpBloc), any));

      await tester.tap(find.byKey(PositiveAffirmationsKeys.changeNameButton));

      await tester.pumpAndSettle();

      verify(mockObserver.didPop(
        NickNameFormScreen.route(signUpBloc),
        NameFormScreen.route(),
      ));
    });
  });
}
