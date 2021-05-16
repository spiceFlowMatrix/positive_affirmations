import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';
import 'package:mobile_app/account_setup/models/name_field.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/fixtures.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockNickNameField extends Mock implements NameField {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  const mockValidName = 'validName';
  const mockValidNickName = 'validNickName';
  const mockInvalidNickName = '35.n\'fwe342-';
  const mockValidSignUpState = SignUpState(
    name: const NameField.dirty(mockValidName),
    nameStatus: FormzStatus.submissionSuccess,
  );

  group('[NickNameForm]', () {
    late SignUpBloc signUpBloc;
    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
      registerFallbackValue<SignUpBloc>(MockSignUpBloc());
    });

    setUp(() {
      signUpBloc = MockSignUpBloc();
    });

    test('NickName form screen is routable', () {
      expect(NickNameFormScreen.route(signUpBloc), isA<MaterialPageRoute>());
    });

    testWidgets('NickNameForm renders when NameForm is submitted',
        (tester) async {
      when(() => signUpBloc.state).thenReturn(SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: NickNameFormScreen(signUpBloc),
        ),
      );

      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameFormScreen),
        findsOneWidget,
      );
    });

    testWidgets('components are rendered', (tester) async {
      when(() => signUpBloc.state).thenReturn(mockValidSignUpState);
      await tester.pumpWidget(NickNameFormFixture(signUpBloc));

      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameFieldLabel),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameField),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.changeNameButton),
        findsOneWidget,
      );
    });

    testWidgets('pure and empty nickname does not show error', (tester) async {
      when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
        nickName: const NickNameField.pure(),
        nickNameStatus: FormzStatus.pure,
      ));

      await tester.pumpWidget(NickNameFormFixture(signUpBloc));

      expect(
        tester
            .widget<TextField>(
                find.byKey(PositiveAffirmationsKeys.nickNameField))
            .decoration!
            .errorText,
        isNull,
      );
    });

    testWidgets('pressing back button pops back to name form', (tester) async {
      // final mockObserver = MockNavigatorObserver();
      final GlobalKey<NavigatorState> navigatorKey =
          GlobalKey<NavigatorState>();

      when(() => signUpBloc.state).thenReturn(const SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(MaterialApp(
        home: NameFormScreen(),
        // navigatorObservers: [mockObserver],
        navigatorKey: navigatorKey,
        onGenerateRoute: (_) => NameFormScreen.route(),
      ));
      print(navigatorKey.currentWidget!.key.toString());

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        mockValidName,
      );

      await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

      await tester.pumpAndSettle();

      // verify(() => mockObserver.didPush(
      //       NickNameFormScreen.route(signUpBloc),
      //       any(),
      //     ));

      // await tester.tap(find.byKey(PositiveAffirmationsKeys.changeNameButton));
      //
      // await tester.pumpAndSettle();

      // verify(() => mockObserver.didPop(
      //       NickNameFormScreen.route(signUpBloc),
      //       NameFormScreen.route(),
      //     ));
    });

    group('[FormWiredToBloc]', () {
      testWidgets('entering nickname updates state', (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState);

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        await tester.enterText(
          find.byKey(PositiveAffirmationsKeys.nickNameField),
          mockValidNickName,
        );

        verify(() => signUpBloc.add(NickNameUpdated(mockValidNickName)))
            .called(1);
      });

      testWidgets('error shows when nickname field is invalid', (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
          nickName: NickNameField.dirty(mockInvalidNickName),
          nickNameStatus: FormzStatus.invalid,
        ));

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        expect(
          tester
              .widget<TextField>(
                  find.byKey(PositiveAffirmationsKeys.nickNameField))
              .decoration!
              .errorText,
          isA<String>(),
        );
      });

      testWidgets('valid label text is rendered', (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState);

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        // Reference https://stackoverflow.com/a/41153547/5472560
        expect(
          find.byWidgetPredicate((widget) =>
              widget is RichText &&
              widget.key == PositiveAffirmationsKeys.nickNameFieldLabel &&
              widget.text.toPlainText() ==
                  'Nice to meet you $mockValidName\nOne more question.\nWhat would you like me to call you? 😉'),
          findsOneWidget,
        );
      });

      testWidgets('submit button is disabled when form is errored',
          (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
            nickName: const NickNameField.dirty(mockInvalidNickName),
            nickNameStatus: FormzStatus.invalid));

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        expect(
          tester
              .widget<ElevatedButton>(
                  find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton))
              .enabled,
          isFalse,
        );
      });

      testWidgets('submit button is enabled when form is pure', (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
          nickName: const NickNameField.pure(),
          nickNameStatus: FormzStatus.pure,
        ));

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        expect(
          tester
              .widget<ElevatedButton>(
                  find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton))
              .enabled,
          isTrue,
        );
      });

      testWidgets('submit button is enabled when form is valid',
          (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
          // nickName: const NickNameField.dirty(mockValidNickName),
          nickNameStatus: FormzStatus.valid,
        ));

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        expect(
          tester
              .widget<ElevatedButton>(
                  find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton))
              .enabled,
          isTrue,
        );
      });

      testWidgets('tapping submit button is enabled when form is valid',
          (tester) async {
        when(() => signUpBloc.state).thenReturn(mockValidSignUpState.copyWith(
          // nickName: const NickNameField.dirty(mockValidNickName),
          nickNameStatus: FormzStatus.valid,
        ));

        await tester.pumpWidget(NickNameFormFixture(signUpBloc));

        await tester
            .tap(find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton));

        verify(() => signUpBloc.add(NickNameSubmitted())).called(1);
      });
    });
  });
}
